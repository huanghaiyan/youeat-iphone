//
//  DetailRestaurant.h
//  YouEat
//
//  Created by Alessandro Vincelli on 10/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailRestaurant : UITableViewController

@property (nonatomic, retain) NSDictionary *ristoItem;
@property (nonatomic, retain) NSDictionary *ristoPosition;
@property (nonatomic, retain) NSDecimalNumber *distanceInMeters;
@end
