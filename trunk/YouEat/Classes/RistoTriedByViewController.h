//
//  RistoTriedByViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 7/23/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestUtil.h"

@class ASIHTTPRequest;

@interface RistoTriedByViewController : UITableViewController {
	
	NSDictionary *selectedRisto;
	NSMutableArray *listOfUser;
	IBOutlet UITableView *tableViewUser;
	RestUtil *restUtil;
	ASIHTTPRequest *request;
}

@property (nonatomic, retain) NSDictionary *selectedRisto;
@property (nonatomic, retain) IBOutlet UITableView *tableViewUser;
@property (nonatomic, retain) IBOutlet NSMutableArray *listOfUser;
@property (nonatomic, retain) RestUtil *restUtil;
@property (retain, nonatomic) ASIHTTPRequest *request;

@end
