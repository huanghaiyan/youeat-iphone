//
//  AccountViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 6/29/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import "LoggedUserViewController.h"
#import "ASIHTTPRequest.h"
#import "LoginViewController.h"
#import "FavouriteRistoViewController.h"
#import "FriendActivitiesViewController.h"
#import "FriendListViewController.h"
#import "LoggedUser.h"

@implementation LoggedUserViewController;

@synthesize tableViewMenu;


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	if(indexPath.row == 0){
		cell.detailTextLabel.text = @"My favorites";
	}
	if(indexPath.row == 1){
		cell.detailTextLabel.text = @"My friend activities";
	}
	if(indexPath.row == 2){
		cell.detailTextLabel.text = @"My friends";
	}
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if(indexPath.row == 0){
		FavouriteRistoViewController *viewController = [[FavouriteRistoViewController alloc] initWithNibName:@"FavouriteRistoViewController" bundle:[NSBundle mainBundle]];
		[self.navigationController pushViewController:viewController animated:TRUE];
		[viewController release];
	}
	if(indexPath.row == 1){
		FriendActivitiesViewController *viewController = [[FriendActivitiesViewController alloc] initWithNibName:@"FriendActivitiesViewController" bundle:[NSBundle mainBundle]];
		[self.navigationController pushViewController:viewController animated:TRUE];
		[viewController release];
	}
	if(indexPath.row == 2){
		FriendListViewController *viewController = [[FriendListViewController alloc] init];
		[self.navigationController pushViewController:viewController animated:TRUE];
		[viewController release];
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
}

- (void)viewDidLoad {

}

 - (void)viewWillAppear:(BOOL)animated {
	 [self showLogin];
	 [super viewWillAppear:animated];
 }

- (void)dealloc {
	[tableViewMenu release];
    [super dealloc];
}

- (void)showLogin{
	if([LoggedUser loggedUserID] == NULL){
		LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
		[self setModalTransitionStyle:UIModalPresentationFormSheet];
		[self presentModalViewController:loginViewController animated:YES];
		[loginViewController release];
	}	   
}

@end
