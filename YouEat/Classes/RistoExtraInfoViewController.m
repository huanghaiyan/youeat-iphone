//
//  RistoExtraInfoViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 7/21/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import "RistoExtraInfoViewController.h"
#import "RistoScrollViewController.h"
#import "URLUtil.h"
#import "ASIHTTPRequest.h"
#import "LoggedUser.h"
#import "JSON/JSON.h"
#import "ActivityCell.h"
#import "IconUtil.h"

@implementation RistoExtraInfoViewController

@synthesize restUtil, listOfActivities, request, tableViewActivities, imageView, selectedRisto;

- (void) startsGetActivities {
	[listOfActivities removeAllObjects];
	
	NSString *urlString = [NSString stringWithFormat:@"/security/lastActivitiesOnRestaurant/%@", [selectedRisto objectForKey:@"id"]]; 
	NSString *baseUrl = [URLUtil getConnectionUrl];
	[self setRequest:[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[baseUrl stringByAppendingString:urlString]]]];
	[request setDelegate:self];
	[request setShouldPresentAuthenticationDialog:FALSE];
	[request setDidFinishSelector:@selector(activitiesFetchComplete:)];
	[request setDidFailSelector:@selector(activitiesFetchFailed:)];
	[request startAsynchronous];
	
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My friend activities";
	listOfActivities = [[[NSMutableArray alloc] init] retain ];
	restUtil = [[[RestUtil alloc] init] retain ];
	[self startsGetActivities];
}


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return @"last activities";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listOfActivities count];
}

- (void)configureCell:(ActivityCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell
	NSDictionary *activityItem = [listOfActivities objectAtIndex:indexPath.row];
	NSDictionary *ristoItem = [activityItem objectForKey:@"ristorante"];
	NSDictionary *eater = [activityItem objectForKey:@"eater"];
	cell.nameLabel.text = [ristoItem objectForKey:@"name"];
	
	cell.overviewLabel.text = [NSString stringWithFormat:@"%@ %@ %@", [eater objectForKey:@"firstname"], [eater objectForKey:@"lastname"], [activityItem objectForKey:@"activityDesc"]];
	cell.cityLabel.text = [[ristoItem objectForKey:@"city"] objectForKey:@"name"];
	NSString *iconName = [IconUtil getActivityIcon:[activityItem objectForKey:@"type"]];
	cell.imageView.image = [[UIImage imageNamed:iconName] retain];
	cell.timeLabel.text = [activityItem objectForKey:@"elapsedTime"];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Dequeue or if necessary create a RecipeTableViewCell, then set its recipe to the recipe for the current row.
    static NSString *ActivityCellIdentifier = @"ActivityCellIdentifier";
    
    ActivityCell *activityCell = (ActivityCell *)[tableView dequeueReusableCellWithIdentifier:ActivityCellIdentifier];
    if (activityCell == nil) {
        activityCell = [[[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ActivityCellIdentifier] autorelease];
    }
    
	[self configureCell:activityCell atIndexPath:indexPath];
    
    return activityCell;
}


- (IBAction)activitiesFetchFailed:(ASIHTTPRequest *)theRequest
{
	//responseField.hidden = NO;
	//[responseField setText:@"Username and password not correct\nPlease retry."];
}

- (IBAction)activitiesFetchComplete:(ASIHTTPRequest *)theRequest
{
	BOOL success = ([request responseStatusCode] == 200);
	if(success){
		//retry the user info
		SBJSON *parser = [[SBJSON alloc] init];
		NSString *json_string = [[NSString alloc] initWithData:[theRequest responseData] encoding:NSUTF8StringEncoding];
		NSDictionary *statuses = [parser objectWithString:json_string error:nil];
		
		NSDictionary *ristoranteList = [statuses objectForKey:@"activityRistoranteList"];
		
		NSEnumerator *ristoranteEnum = [ristoranteList objectEnumerator];
		
		id object;
		while ((object = [ristoranteEnum nextObject])) {
			[listOfActivities addObject:object];
		}
		
		[self.tableView reloadData];
	}
	else{
		//todo
	}	
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
	[tableViewActivities release];
	[restUtil release];
	[listOfActivities release];
	[request release];
	[imageView release];
    [super dealloc];
}

@end

