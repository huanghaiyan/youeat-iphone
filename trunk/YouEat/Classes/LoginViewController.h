//
//  LoginViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 6/30/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect/FBLoginButton.h"
#import "LoggedUserViewController.h"

@class ASIHTTPRequest;

@interface LoginViewController : UIViewController <FBSessionDelegate>{
	ASIHTTPRequest *request;
	UITextField *userName;
	UITextField *password;
	UIButton *login;
	UIButton *cancel;
	UILabel *responseField;
	LoggedUserViewController *loggedUserViewController;
	FBSession *session_;
}

- (IBAction)fetchTopSecretInformation;
- (IBAction)cancelLogin;
- (IBAction)loginByShowingDialog;

@property (nonatomic, retain) IBOutlet UILabel *responseField;
@property (nonatomic, retain) IBOutlet UITextField *userName;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UIButton *login;
@property (nonatomic, retain) IBOutlet UIButton *cancel;
@property (retain, nonatomic) ASIHTTPRequest *request;
@property (retain, nonatomic) FBSession *session_;
@property (nonatomic, retain) LoggedUserViewController *loggedUserViewController;

@end
