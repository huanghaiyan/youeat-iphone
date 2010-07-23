//
//  FirstViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright Alessandro Vincelli 2010. All rights reserved.
//

#import "FirstViewController.h"
#import "RistoScrollViewController.h"
#import "LoginUtil.h"


@implementation FirstViewController

@synthesize searchBar, listOfRisto, tableViewRisto, restUtil;


- (void)viewDidLoad {
    [super viewDidLoad];
	listOfRisto = [[[NSMutableArray alloc] init] retain ];
	restUtil = [[[RestUtil alloc] init] retain ];
    self.title = @"Search";
	self.tableView.scrollEnabled = YES;
	LoginUtil *loginUtil = [[[LoginUtil alloc] init] retain ];
	//COMMENT the following line before to release
	//[loginUtil fetchTopSecretInformation];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	[self searchRisto:theSearchBar.text];
	self.navigationItem.rightBarButtonItem = nil;
	[searchBar resignFirstResponder];
	[self.tableViewRisto reloadData];
}

- (void) searchRisto:(NSString *)searchText{
	
	NSString *urlString = @"";
	
	if([searchText length] > 2) {
		[listOfRisto retain];
		[listOfRisto removeAllObjects];
		NSString *text = [searchText stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		urlString = [NSString stringWithFormat:@"/findRistoranti/%@", text]; 
		//performs the search
		NSDictionary *statuses = [restUtil sendRestRequest:urlString];
		
		NSDictionary *ristoranteList = [statuses objectForKey:@"ristoranteList"];
		
		NSEnumerator *ristoranteEnum = [ristoranteList objectEnumerator];
		
		NSDictionary *risto;
		while ((risto = [ristoranteEnum nextObject])) {
			[listOfRisto addObject:risto];
		}
		[listOfRisto release];
	}
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [listOfRisto count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	// Configure the cell.
	NSDictionary *ristoItem = [listOfRisto objectAtIndex:indexPath.row];
	cell.textLabel.text = [ristoItem objectForKey:@"name"];
	NSString *city = [[ristoItem objectForKey:@"city"] objectForKey:@"name"];
	NSString *address = [ristoItem objectForKey:@"address"];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", city, address]; ;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *selectedRisto = [listOfRisto objectAtIndex:indexPath.row];
    [self showRisto:selectedRisto animated:YES];
}

- (void)showRisto:(NSDictionary *)risto animated:(BOOL)animated {
	RistoScrollViewController *detailViewController = [[RistoScrollViewController alloc] initWithNibName:@"RistoScrollView" bundle:[NSBundle mainBundle]];
	detailViewController.selectedRisto = risto;    
    [self.navigationController pushViewController:detailViewController animated:animated];
    [detailViewController release];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[tableViewRisto release];
	[restUtil release];
	[listOfRisto release];
    [super dealloc];
}

@end
