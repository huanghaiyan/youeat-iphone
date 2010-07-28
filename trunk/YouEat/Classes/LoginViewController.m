//
//  LoginViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 6/30/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import "LoginViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "FirstViewController.h"
#import "URLUtil.h"
#import "LoggedUser.h"
#import "JSON/JSON.h"
#import "LoggedUserViewController.h"
#import "FBConnect/FBLoginDialog.h"


@implementation LoginViewController

@synthesize request, userName, password, login, responseField, cancel, loggedUserViewController, session_;

- (IBAction)cancelLogin{
	[self dismissModalViewControllerAnimated:TRUE];
	self.loggedUserViewController.islogged = FALSE;
}

- (IBAction)fetchTopSecretInformation
{
	[userName resignFirstResponder];
	[password resignFirstResponder];
	NSString *url = [URLUtil getConnectionUrl];
	[self setRequest:[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[url stringByAppendingString:@"/security/signUp"]]]];
	[request setDelegate:self];
	[request setShouldPresentAuthenticationDialog:FALSE];
	[[self request] setUsername:[userName text]];
	[[self request] setPassword:[password text]];
	[request setDidFinishSelector:@selector(topSecretFetchComplete:)];
	[request setDidFailSelector:@selector(topSecretFetchFailed:)];
	[request startAsynchronous];
}

- (IBAction)topSecretFetchFailed:(ASIHTTPRequest *)theRequest
{
	responseField.hidden = NO;
	[responseField setText:@"Username and password not correct\nPlease retry."];
}

/* Analyze and extract the User from a JSON response
 */
- (IBAction)topSecretFetchComplete:(ASIHTTPRequest *)theRequest
{
	BOOL success = ([theRequest responseStatusCode] == 200);
	if(success){
		//retry the user info
		SBJSON *parser = [[SBJSON alloc] init];
		NSString *json_string = [[NSString alloc] initWithData:[theRequest responseData] encoding:NSUTF8StringEncoding];
		NSLog(@"json_string %@ logged in.", json_string);
		NSDictionary *statuses = [parser objectWithString:json_string error:nil];
		NSDictionary *eater = [statuses objectForKey:@"eater"];
		[LoggedUser setloggedUserID:[eater objectForKey:@"email"]];
		NSLog(@"User with email %@ logged in.", [eater objectForKey:@"email"]);
		[self dismissModalViewControllerAnimated:TRUE];
	}
	else{
		//todo
	}	
}

- (void)viewDidLoad {
	responseField.hidden = YES;
	//Try to resume a FB session
	if(session_ == NULL){
		session_ = [[FBSession sessionForApplication:@"083c31f005625c34a27aa011a279322b" secret:@"55e243cb76143b12b68acc48ccdb4920" delegate:self] retain];
		[session_ resume];
	}
}

// Show a FB login Dialog
- (void)loginByShowingDialog {
    FBLoginDialog* dialog = [[[FBLoginDialog alloc] initWithSession:self.session_] autorelease];
    dialog.delegate = self;
    [dialog show];
}

// the method is called after a succesfull authentication on FB
// performs the signup on YouEat sending the session key and the uid obtained by FB
- (void)performFBSignUpOnYouEat
{
	NSString *url = [URLUtil getConnectionUrl];
	ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[url stringByAppendingString:@"/security/signUpFB"]]];
	[req setPostValue:session_.sessionKey forKey:@"session_key"];
	[req setPostValue:[NSString stringWithFormat:@"%lld", session_.uid] forKey:@"uid"];
	[req setPostValue:session_.sessionKey forKey:@"espiration_date"];
	//[self setRequest:[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/security/signUp?session_key=%@&uid=%lld&expiration_date=%@", url, session_.sessionKey, session_.uid, session_.expirationDate]]]];
	[req setDelegate:self];
	[req setShouldPresentAuthenticationDialog:FALSE];
	[req setDidFinishSelector:@selector(performFBSignUpOnYouEatComplete:)];
	[req setDidFailSelector:@selector(topSecretFetchFailed:)];
	[req startAsynchronous];
}

- (void)fetchUserFBInformation
{
	NSString *url = [URLUtil getConnectionUrl];
	ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[url stringByAppendingString:@"/security/signUpFB"]]];
	[req setDelegate:self];
	[req setShouldPresentAuthenticationDialog:FALSE];
	[req setDidFinishSelector:@selector(topSecretFetchComplete:)];
	[req setDidFailSelector:@selector(topSecretFetchFailed:)];
	[req startAsynchronous];
}

- (IBAction)performFBSignUpOnYouEatComplete:(ASIHTTPRequest *)theRequest
{
	BOOL success = ([theRequest responseStatusCode] == 200);
	if(success){
		[self fetchUserFBInformation];
	}
	else{
		//todo
	}	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)session:(FBSession*)session didLogin:(FBUID)uid {
	//NSLog(@"User with id %lld logged in.", uid);
	self.session_ = session;
	[self performFBSignUpOnYouEat];
}

- (void)viewDidUnload {
	[request release];
	[userName release];
	[password release];
	[login release];
	[responseField release];
	[cancel release];
	[LoggedUserViewController release];
	[super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}


@end
