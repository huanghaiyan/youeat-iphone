//
//  FavouriteRistoViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 7/4/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import "FavouriteRistoViewController.h"
#import "RistoViewController.h"
#import "URLUtil.h"
#import "ASIHTTPRequest.h"
#import "LoggedUser.h"
#import "JSON/JSON.h"

@implementation FavouriteRistoViewController

@synthesize tableViewRisto, restUtil, listOfRisto, listOfRistoPosition, locationManager, request;



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My favourites";
	listOfRisto = [[[NSMutableArray alloc] init] retain ];
	listOfRistoPosition = [[[NSMutableArray alloc] init] retain ];
	restUtil = [[[RestUtil alloc] init] retain ];
	[self searchCloseRistorantiView];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


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
	RistoViewController *detailViewController = [[RistoViewController alloc] initWithNibName:@"RistoView" bundle:[NSBundle mainBundle]];
	detailViewController.selectedRisto = risto;    
    [self.navigationController pushViewController:detailViewController animated:animated];
    [detailViewController release];
}

- (void) searchCloseRistorantiView {
	NSLog(@"searchCloseRistorantiView");
	[listOfRisto removeAllObjects];
	//[listOfRistoPosition removeAllObjects];
	
    self.locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    // Once configured, the location manager must be "started".
    [locationManager startUpdatingLocation];
	NSLog(@"END searchCloseRistorantiView");
}

- (IBAction)favoriteRistoFetchFailed:(ASIHTTPRequest *)theRequest
{
	//responseField.hidden = NO;
	//[responseField setText:@"Username and password not correct\nPlease retry."];
}

- (IBAction)favoriteRistoFetchComplete:(ASIHTTPRequest *)theRequest
{
	BOOL success = ([request responseStatusCode] == 200);
	if(success){
		//retry the user info
		SBJSON *parser = [[SBJSON alloc] init];
		NSString *json_string = [[NSString alloc] initWithData:[theRequest responseData] encoding:NSUTF8StringEncoding];
		NSDictionary *statuses = [parser objectWithString:json_string error:nil];
		
		NSDictionary *ristoranteList = [statuses objectForKey:@"ristorantePositionAndDistanceList"];
		
		NSEnumerator *ristoranteEnum = [ristoranteList objectEnumerator];
		
		id object;
		while ((object = [ristoranteEnum nextObject])) {
			NSDictionary *ristoPosition = object;
			[listOfRisto addObject:[ristoPosition objectForKey:@"ristorante"]];
			[listOfRistoPosition addObject:ristoPosition];
		}
		
		[self.tableView reloadData];
	}
	else{
		//todo
	}	
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
	NSString *userID = [LoggedUser loggedUserID];
	NSString *urlString = [NSString stringWithFormat:@"/security/favorite/%@/%@/%@", latitude, longitude, userID]; 
	NSString *baseUrl = [URLUtil getConnectionUrl];
	[self setRequest:[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[baseUrl stringByAppendingString:urlString]]]];
	[request setDelegate:self];
	[request setShouldPresentAuthenticationDialog:FALSE];
	[request setDidFinishSelector:@selector(favoriteRistoFetchComplete:)];
	[request setDidFailSelector:@selector(favoriteRistoFetchFailed:)];
	[request startAsynchronous];
	
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
	[request release];
    [super dealloc];
}

@end