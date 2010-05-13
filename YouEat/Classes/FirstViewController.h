//
//  FirstViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestUtil.h"

@interface FirstViewController : UITableViewController <UISearchBarDelegate, UINavigationBarDelegate>{
	
	NSMutableArray *listOfRisto;
	IBOutlet UISearchBar *searchBar;
	IBOutlet UITableView *tableViewRisto;
	BOOL searching;
	BOOL letUserSelectRow;
	RestUtil *restUtil;
}

- (void) searchRisto:(NSString *)searchText;
- (void)showRisto:(NSDictionary *)risto animated:(BOOL)animated;

@property (nonatomic, retain) IBOutlet UITableView *tableViewRisto;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) IBOutlet NSMutableArray *listOfRisto;
@property (nonatomic, retain) RestUtil *restUtil;

@end

