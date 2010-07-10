//
//  FavouriteRistoViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 7/4/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestUtil.h"
#import "CoreLocation/CoreLocation.h"

@class ASIHTTPRequest;

@interface FavouriteRistoViewController : UITableViewController <UINavigationBarDelegate, CLLocationManagerDelegate>{

	NSMutableArray *listOfRisto;
	NSMutableArray *listOfRistoPosition;
	IBOutlet UITableView *tableViewRisto;
	RestUtil *restUtil;
	CLLocationManager *locationManager;
	ASIHTTPRequest *request;
}

- (void) searchCloseRistorantiView;
- (void)showRisto:(NSDictionary *)risto animated:(BOOL)animated;

@property (nonatomic, retain) IBOutlet UITableView *tableViewRisto;
@property (nonatomic, retain) IBOutlet NSMutableArray *listOfRisto;
@property (nonatomic, retain) IBOutlet NSMutableArray *listOfRistoPosition;
@property (nonatomic, retain) RestUtil *restUtil;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (retain, nonatomic) ASIHTTPRequest *request;

@end
