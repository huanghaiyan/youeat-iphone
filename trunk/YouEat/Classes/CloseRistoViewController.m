//
//  CloseRistoViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import "CloseRistoViewController.h"
#import "RistoViewController.h"
#import "RistoScrollViewController.h"

@implementation CloseRistoViewController


#pragma mark -
#pragma mark Initialization

@synthesize tableViewRisto, restUtil, listOfRisto, listOfRistoPosition, locationManager, spinner;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Around me";
	listOfRisto = [[[NSMutableArray alloc] init] retain ];
	listOfRistoPosition = [[[NSMutableArray alloc] init] retain ];
	restUtil = [[[RestUtil alloc] init] retain ];

}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	spinner = [[UIActivityIndicatorView alloc] 
										initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	spinner.frame = CGRectMake(120,120, 60, 60);
	[self searchCloseRistorantiView];
	[self.view addSubview:spinner];
	[spinner startAnimating];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

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
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


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
	NSString *distance = @"";
	if([listOfRistoPosition count] > 0 ){
		NSDictionary *ristoPositionItem = [listOfRistoPosition objectAtIndex:indexPath.row];
		distance = [distance stringByAppendingString:@""];
		NSDecimalNumber *distanceInMeters = [ristoPositionItem objectForKey:@"distanceInMeters"];
		distance = [distance stringByAppendingString:[distanceInMeters stringValue]];
		distance = [distance stringByAppendingString:@" m."];
	}
	
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@ - %@", distance, city, address]; ;
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
	
	//RistoViewController *detailViewController = [[RistoViewController alloc] initWithNibName:@"RistoView" bundle:[NSBundle mainBundle]];
	//detailViewController.selectedRisto = risto;
    //[self.navigationController pushViewController:detailViewController animated:animated];
    //[detailViewController release];
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
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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


- (void) searchCloseRistorantiView {
	NSLog(@"searchCloseRistorantiView");
	[listOfRisto removeAllObjects];
	//[listOfRistoPosition removeAllObjects];
	
    self.locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    // Once configured, the location manager must be "started".
    NSLog(@"startUpdatingLocation");
	[locationManager startMonitoringSignificantLocationChanges];
	NSLog(@"END searchCloseRistorantiView");
}


/*
 * We want to get and store a location measurement that meets the desired accuracy. For this example, we are
 *      going to use horizontal accuracy as the deciding factor. In other cases, you may wish to use vertical
 *      accuracy, or both together.
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	NSLog(@"didUpdateToLocation");
	//[listOfRisto removeAllObjects];
	//[listOfRistoPosition removeAllObjects];
	
	NSString *latitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
	NSString *longitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
	NSString *urlString = [NSString stringWithFormat:@"/findCloseRistoranti/%@/%@/%@/%@", latitude, longitude, @"90000000000", @"20"]; 
	
	NSDictionary *statuses = [restUtil sendRestRequest:urlString];
	
	NSDictionary *ristoranteList = [statuses objectForKey:@"ristorantePositionAndDistanceList"];
	
	NSEnumerator *ristoranteEnum = [ristoranteList objectEnumerator];
	
	id object;
	while ((object = [ristoranteEnum nextObject])) {
		NSDictionary *ristoPosition = object;
		[listOfRisto addObject:[ristoPosition objectForKey:@"ristorante"]];
		[listOfRistoPosition addObject:ristoPosition];
	}
	[spinner stopAnimating];
    [self.tableView reloadData];
	NSLog(@"END --- didUpdateToLocation");
}

/*
 TODO
 - (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
 if ([error code] != kCLErrorLocationUnknown) {
 [self stopUpdatingLocation:NSLocalizedString(@"Error", @"Error")];
 }
 }
 */

- (void)stopUpdatingLocation:(NSString *)state {
	NSLog(@" stopUpdatingLocation");
    [self.tableView reloadData];
    [locationManager stopUpdatingLocation];
    locationManager.delegate = nil;
	NSLog(@"END --- stopUpdatingLocation");    
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
	[tableViewRisto release];
	[restUtil release];
	[listOfRisto release];
	[listOfRistoPosition release];
	[locationManager release];
	[spinner release];
    [super dealloc];
}

@end