//
//  LoginViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 6/30/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestUtil.h"

@class ASIHTTPRequest;

@interface LoginViewController : UIViewController {
	ASIHTTPRequest *request;
	UITextField *userName;
	UITextField *password;
	UIButton *login;
	UILabel *responseField;
	RestUtil *restUtil;
}

- (IBAction)fetchTopSecretInformation;

@property (nonatomic, retain) IBOutlet UILabel *responseField;
@property (nonatomic, retain) IBOutlet UITextField *userName;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UIButton *login;
@property (retain, nonatomic) ASIHTTPRequest *request;
@property (nonatomic, retain) RestUtil *restUtil;

@end
