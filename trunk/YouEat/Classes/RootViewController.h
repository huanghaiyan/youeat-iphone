//
//  RootViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 08/04/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#import "YouEatConnection.h"

@interface RootViewController : UITableViewController <UISearchBarDelegate>{
	YouEatConnection *youEatConnection;
	IBOutlet UISearchBar *searchBar;
	NSMutableArray *listOfItems;
	NSMutableArray *copyListOfItems;
	NSMutableData *responseData;	
	BOOL searching;
	BOOL letUserSelectRow;
}

- (void) searchTableView;
- (void) doneSearching_Clicked:(id)sender;
- (NSDictionary*) sendRestRequest:(NSString*)url;

@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) YouEatConnection *youEatConnection;

@end
