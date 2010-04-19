//
//  YouEatAppDelegate.h
//  YouEat
//
//  Created by Alessandro Vincelli on 19/04/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YouEatAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	IBOutlet UISearchBar *searchBar;
	IBOutlet UITableView *freeTextTableView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) IBOutlet UITableView *freeTextTableView;

@end
