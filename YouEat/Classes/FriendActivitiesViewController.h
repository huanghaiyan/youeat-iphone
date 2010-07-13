//
//  FriendActivitiesViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 7/12/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "RestUtil.h"

@class ASIHTTPRequest;

@interface FriendActivitiesViewController :  UITableViewController <UINavigationBarDelegate>{
	
	NSMutableArray *listOfActivities;
	IBOutlet UITableView *tableViewActivities;
	RestUtil *restUtil;
	ASIHTTPRequest *request;
	UIImageView *imageView;
}

- (void)showRisto:(NSDictionary *)risto animated:(BOOL)animated;

@property (nonatomic, retain) IBOutlet UITableView *tableViewActivities;
@property (nonatomic, retain) IBOutlet NSMutableArray *listOfActivities;
@property (nonatomic, retain) RestUtil *restUtil;
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain) UIImageView *imageView;

@end