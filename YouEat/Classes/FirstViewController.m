//
//  FirstViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "FirstViewController.h"
#import "RistoViewController.h"


@implementation FirstViewController

@synthesize searchBar, listOfRisto, tableViewRisto, restUtil;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
	listOfRisto = [[[NSMutableArray alloc] init] retain ];
	restUtil = [[[RestUtil alloc] init] retain ];
    self.title = @"Search";
	self.tableView.scrollEnabled = YES;
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
	//NSString *phone = [ristoItem objectForKey:@"phoneNumber"];
	
	//if (phone == [NSNull null] || phone.length == 0 ) phone = @"";
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", city, address]; ;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *selectedRisto = [listOfRisto objectAtIndex:indexPath.row];
    [self showRisto:selectedRisto animated:YES];
}

- (void)showRisto:(NSDictionary *)risto animated:(BOOL)animated {
	RistoViewController *detailViewController = [[RistoViewController alloc] initWithNibName:@"RistoView" bundle:[NSBundle mainBundle]];
	detailViewController.selectedRisto = risto;    
    [self.navigationController pushViewController:detailViewController animated:animated];
    [detailViewController release];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
