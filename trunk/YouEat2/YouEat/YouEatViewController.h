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

@interface YouEatViewController : UIViewController <UITextFieldDelegate>
@property (nonatomic, readonly) RestUtil *restUtil;
@property (nonatomic, retain) NSMutableArray *listOfRisto;

@end
