//
//  FriendListViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 7/23/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import "FriendListViewController.h"
#import "RistoScrollViewController.h"
#import "URLUtil.h"
#import "ASIHTTPRequest.h"
#import "LoggedUser.h"
#import "JSON/JSON.h"

@implementation FriendListViewController

@synthesize tableViewUser, restUtil, listOfUser, request;

- (void)viewDidLoad {
    [super viewDidLoad];
	listOfUser = [[[NSMutableArray alloc] init] retain ];
	restUtil = [[[RestUtil alloc] init] retain ];
	NSString *urlString = [NSString stringWithFormat:@"/security/getFriends"]; 
	NSString *baseUrl = [URLUtil getConnectionUrl];
	[self setRequest:[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[baseUrl stringByAppendingString:urlString]]]];
	[request setDelegate:self];
	[request setShouldPresentAuthenticationDialog:FALSE];
	[request setDidFinishSelector:@selector(favoriteRistoFetchComplete:)];
	[request setDidFailSelector:@selector(favoriteRistoFetchFailed:)];
	[request startAsynchronous];
	
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return @"my friends";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listOfUser count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	NSDictionary *userItem = [listOfUser objectAtIndex:indexPath.row];
	NSString *firstname = [userItem objectForKey:@"firstname"];
	NSString *lastname = [userItem objectForKey:@"lastname"];
	cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", firstname, lastname];
	//cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@ - %@", distance, city, address];
    return cell;
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
		
		NSDictionary *userList = [statuses objectForKey:@"eaterList"];
		
		NSEnumerator *userEnum = [userList objectEnumerator];
		
		id user;
		while ((user = [userEnum nextObject])) {
			[listOfUser addObject:user];
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
	[tableViewUser release];
	[restUtil release];
	[listOfUser release];
	[request release];
    [super dealloc];
}

@end