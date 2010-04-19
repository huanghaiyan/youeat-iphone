//
//  FirstViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 19/04/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "FirstViewController.h"
#import "JSON/JSON.h"

@implementation FirstViewController

@synthesize searchBar;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	listOfRisto = [[[NSMutableArray alloc] init] retain ];
	self.tableView.scrollEnabled = YES;
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

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	[listOfRisto retain];
	NSString *searchText = theSearchBar.text;
	NSString *urlString;
	[listOfRisto removeAllObjects];
	
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
		[listOfRisto addObject:risto];
	}
	[theSearchBar resignFirstResponder];
	[self.tableView reloadData];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [listOfRisto count];
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
	NSDictionary *ristoItem = [listOfRisto objectAtIndex:indexPath.row];
	cell.textLabel.text = [ristoItem objectForKey:@"name"];
	NSString *city = [[ristoItem objectForKey:@"city"] objectForKey:@"name"];
	NSString *address = [ristoItem objectForKey:@"address"];
	//NSString *phone = [ristoItem objectForKey:@"phoneNumber"];
	
	//if (phone == [NSNull null] || phone.length == 0 ) phone = @"";
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", city, address]; ;
    return cell;
}

/*
 To conform to Human Interface Guildelines, since selecting a row would have no effect (such as navigation), make sure that rows cannot be selected.
 */
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}
- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


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
}

@end
