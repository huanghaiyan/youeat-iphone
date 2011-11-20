//
//  ListRestaurants.h
//  YouEat
//
//  Created by Alessandro Vincelli on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocation/CoreLocation.h"
#import "RestUtil.h"
#import "JKCustomAlert.h"

@interface ListRestaurants : UIViewController <UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource, YRestUtilDelegate, JKCustomAlertDelegate>

@property (nonatomic, retain) NSMutableArray *ristos;
@property (nonatomic, retain) IBOutlet UINavigationItem *navigationItem;
@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UITableView *tw;
@property (nonatomic) NSInteger selectedRow;
@property (nonatomic, retain) NSString *pattern;
@property (nonatomic, retain) CLLocation *location;
@property (nonatomic, retain) RestUtil *restUtil;
@property (nonatomic, retain) JKCustomAlert  *alertView;

@end
