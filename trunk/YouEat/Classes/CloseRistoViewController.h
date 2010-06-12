//
//  CloseRistoViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestUtil.h"
#import "CoreLocation/CoreLocation.h"

@interface CloseRistoViewController : UITableViewController <UINavigationBarDelegate, CLLocationManagerDelegate>{

	NSMutableArray *listOfRisto;
	NSMutableArray *listOfRistoPosition;
	IBOutlet UITableView *tableViewRisto;
	RestUtil *restUtil;
	CLLocationManager *locationManager;
}

- (void) searchCloseRistorantiView;
- (void)showRisto:(NSDictionary *)risto animated:(BOOL)animated;

@property (nonatomic, retain) IBOutlet UITableView *tableViewRisto;
@property (nonatomic, retain) IBOutlet NSMutableArray *listOfRisto;
@property (nonatomic, retain) IBOutlet NSMutableArray *listOfRistoPosition;
@property (nonatomic, retain) RestUtil *restUtil;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end
