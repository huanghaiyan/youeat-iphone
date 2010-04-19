//
//  FirstViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 19/04/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UITableViewController <UISearchBarDelegate> {
	
	//NSMutableArray *listOfRisto;
//	NSMutableArray *listOfRistoPosition;
//	BOOL searching;
//	BOOL letUserSelectRow;
}

- (NSDictionary*) sendRestRequest:(NSString*)url;

@end
