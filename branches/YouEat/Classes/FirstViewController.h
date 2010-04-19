//
//  FirstViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 19/04/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UITableViewController {
	
	NSMutableArray *listOfRisto;
	IBOutlet UISearchBar *searchBar;
}

- (NSDictionary*) sendRestRequest:(NSString*)url;

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

@end
