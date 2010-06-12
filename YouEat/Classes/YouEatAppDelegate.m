//
//  YouEatAppDelegate.m
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright Alessandro Vincelli 2010. All rights reserved.
//

#import "YouEatAppDelegate.h"


@implementation YouEatAppDelegate

@synthesize window;
@synthesize tabBarController;
//@synthesize navigationBar;
	

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

