//
//  RootViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 08/04/10.
//  Copyright Alessandro Vincelli 2010. All rights reserved.
//

#import "RootViewController.h"
#import "JSON/JSON.h"
#import "RistoranteDetailViewController.h"
#import "YouEatConnection.h"


@implementation RootViewController

@synthesize searchBar;
@synthesize youEatConnection;

- (void)viewDidLoad {
	//youEatConnection = [YouEatConnection new];
    [super viewDidLoad];
	
    self.title = @"YouEat";
	
	listOfItems = [[NSMutableArray alloc] init];
	
	responseData = [[NSMutableData data] retain];
	
	[self searchTableView];

	//Add the search bar

	self.searchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 44.0)] autorelease];
	self.searchBar.delegate = self;
	self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	self.tableView.tableHeaderView = searchBar;
	
	searching = NO;
	letUserSelectRow = YES;
    
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [listOfItems count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	// Configure the cell.
	NSDictionary *ristoItem = [listOfItems objectAtIndex:indexPath.row];
	cell.textLabel.text = [ristoItem objectForKey:@"name"];
	NSString *city = [[ristoItem objectForKey:@"city"] objectForKey:@"name"];
	NSString *address = [ristoItem objectForKey:@"address"];
	NSString *phone = [ristoItem objectForKey:@"phoneNumber"];
	
	if (phone == [NSNull null] || phone.length == 0 ) phone = @"";
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@ %@", city, address, phone]; ;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	NSDictionary *selectedRisto = [listOfItems objectAtIndex:indexPath.row];

	RistoranteDetailViewController *dvController = [[RistoranteDetailViewController alloc] initWithNibName:@"RistoranteDetailView" bundle:[NSBundle mainBundle]];
	dvController.selectedRisto = selectedRisto;
	[self.navigationController pushViewController:dvController animated:YES];
	[dvController release];
	dvController = nil;
	
}


- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	
	searching = YES;
	letUserSelectRow = NO;
	self.tableView.scrollEnabled = NO;
	
	//Add the done button.
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
											   initWithBarButtonSystemItem:UIBarButtonSystemItemDone
											   target:self action:@selector(doneSearching_Clicked:)] autorelease];
}

- (NSIndexPath *)tableView :(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(letUserSelectRow)
		return indexPath;
	else
		return nil;
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
	
	//Remove all objects first.
	//[copyListOfItems removeAllObjects];
	
	if([searchText length] > 2) {
		
		searching = YES;
		letUserSelectRow = YES;
		self.tableView.scrollEnabled = YES;
		[self searchTableView];
	}
	else {
		
		searching = NO;
		letUserSelectRow = NO;
		self.tableView.scrollEnabled = NO;
	}
	
	[self.tableView reloadData];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	[self searchTableView];
}

- (void) searchTableView {
	NSString *urlString;
	[listOfItems removeAllObjects];
	
	NSString *searchText = searchBar.text;
	
	if([searchText length] > 2) {
		NSString *text = [searchText stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		urlString = [NSString stringWithFormat:@"findRistoranti/%@", text]; 
	}
	else {
		urlString = @"ristoranti"; 
	}
	//TODO
	//NSDictionary *statuses = [youEatConnection sendRestRequest:urlString];
	NSDictionary *statuses = [self sendRestRequest:urlString];

	NSDictionary *ristoranteList = [statuses objectForKey:@"ristoranteList"];
	
	NSEnumerator *ristoranteEnum = [ristoranteList objectEnumerator];
	
	id object;
	while ((object = [ristoranteEnum nextObject])) {
		NSDictionary *risto = object;
		[listOfItems addObject:risto];
	}
}



- (void) doneSearching_Clicked:(id)sender {	
	searchBar.text = @"";
	[self.searchBar resignFirstResponder];
	
	letUserSelectRow = YES;
	searching = NO;
	self.navigationItem.rightBarButtonItem = nil;
	self.tableView.scrollEnabled = YES;
	
	[self.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (NSDictionary*) sendRestRequest:(NSString *)url{	
	NSURLRequest *request;
	NSDictionary *statuses;
	NSString *baseURL = @"http://localhost:8080/rest/";
	
	
	SBJSON *parser = [[SBJSON alloc] init];
	
	NSString *urlString = [baseURL stringByAppendingString:url]; 
	request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];	
	
	//	[[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	// Perform request and get JSON back as a NSData object
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	
	// Get JSON as a NSString from NSData response
	NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
	
	// parse the JSON response into an object
	// Here we're using NSArray since we're parsing an array of JSON status objects
	statuses = [parser objectWithString:json_string error:nil];
	return statuses;
}



- (void)dealloc {
    [super dealloc];
	[searchBar release];
}



@end

