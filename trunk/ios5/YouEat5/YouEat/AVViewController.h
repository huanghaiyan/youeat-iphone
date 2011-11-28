//
//  AVViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 10/14/11.
//  Copyright (c) 2011 Wedjaa. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "JKCustomAlert.h"
#import "CoreLocation/CoreLocation.h"
#import "RestUtil.h"

@interface AVViewController : UIViewController <UITextFieldDelegate, JKCustomAlertDelegate, CLLocationManagerDelegate, YRestUtilDelegate>{
    NSMutableArray *listOfRisto;
    CLLocationManager *locationManager;
}

@property (nonatomic, retain) NSArray *listOfRisto;
@property (nonatomic, retain) JKCustomAlert *alertView;
@property (nonatomic, retain) UITextField *searchInput;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *location;
@property (nonatomic, retain) IBOutlet UIButton *aboutBtn;
@property (nonatomic, retain) RestUtil *restUtil;
@property (nonatomic, retain) NSString *pattern;

@end
