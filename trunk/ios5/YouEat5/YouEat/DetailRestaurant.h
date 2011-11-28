//
//  DetailRestaurant.h
//  YouEat
//
//  Created by Alessandro Vincelli on 10/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocation/CoreLocation.h"

@interface DetailRestaurant : UIViewController <UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSDictionary *ristoItem;
@property (nonatomic, retain) NSDictionary *ristoPosition;
@property (nonatomic, retain) NSDecimalNumber *distanceInMeters;
@property (nonatomic, retain) IBOutlet UINavigationItem *navigationItem;
@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UITableView *tw;
@property (nonatomic, retain) NSArray *ristos;
@property (nonatomic, retain) NSString *pattern;
@property (nonatomic, retain) CLLocation *location;


-(IBAction)callPhone:(id)sender;

@end


