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

@interface YouEatViewController : UIViewController <UITextFieldDelegate, JKCustomAlertDelegate>{

}
@property (nonatomic, readonly) RestUtil *restUtil;
@property (nonatomic, retain) NSMutableArray *listOfRisto;
@property (nonatomic, retain) JKCustomAlert *alertView;
@property (nonatomic, retain) UITextField *searchInput;
@end
