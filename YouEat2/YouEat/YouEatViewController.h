//
//  YouEatViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RestUtil.h"
#import "JKCustomAlert.h"
#import "CoreLocation/CoreLocation.h"

@interface YouEatViewController : UIViewController <UITextFieldDelegate, JKCustomAlertDelegate, YRestUtilDelegate, CLLocationManagerDelegate>{
    NSMutableArray *listOfRisto;
    CLLocationManager *locationManager;
}
@property (nonatomic, readonly) RestUtil *restUtil;
@property (nonatomic, retain) NSArray *listOfRisto;
@property (nonatomic, retain) JKCustomAlert *alertView;
@property (nonatomic, retain) UITextField *searchInput;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *location;
@property (nonatomic, retain) UIButton *aboutBtn;
@end
