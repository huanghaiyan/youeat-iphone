//
//  RistoExtraInfoViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 7/21/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestUtil.h"

@class ASIHTTPRequest;

@interface RistoExtraInfoViewController : UITableViewController {

	NSDictionary *selectedRisto;
	NSMutableArray *listOfActivities;
	IBOutlet UITableView *tableViewActivities;
	RestUtil *restUtil;
	ASIHTTPRequest *request;
	UIImageView *imageView;
}

@property (nonatomic, retain) NSDictionary *selectedRisto;
@property (nonatomic, retain) IBOutlet UITableView *tableViewActivities;
@property (nonatomic, retain) IBOutlet NSMutableArray *listOfActivities;
@property (nonatomic, retain) RestUtil *restUtil;
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain) UIImageView *imageView;


@end
