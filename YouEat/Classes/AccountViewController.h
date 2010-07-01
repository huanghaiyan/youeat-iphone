//
//  AccountViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 6/29/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIHTTPRequest;	

@interface AccountViewController : UIViewController {
	ASIHTTPRequest *request;
	UITextView *responseField;
}

- (IBAction)fetchTopSecretInformation;
- (void)showLogin;
@property (nonatomic, retain) IBOutlet UITextView *responseField;

@property (retain, nonatomic) ASIHTTPRequest *request;

@end
