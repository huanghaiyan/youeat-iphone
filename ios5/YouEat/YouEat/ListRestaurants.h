//
//  ListRestaurants.h
//  YouEat
//
//  Created by Alessandro Vincelli on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListRestaurants : UIViewController <UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSArray *ristos;
@property (nonatomic, retain) IBOutlet UINavigationItem *navigationItem;
@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UITableView *tw;
@property (nonatomic) NSInteger selectedRow;

@end
