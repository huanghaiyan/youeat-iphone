//
//  LoginViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 6/30/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import "LoginViewController.h"
#import "ASIHTTPRequest.h"
#import "FirstViewController.h"
#import "URLUtil.h"
#import "LoggedUser.h"
#import "JSON/JSON.h"

@implementation LoginViewController

@synthesize request, userName, password, login, responseField, cancel, restUtil;

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

- (IBAction)topSecretFetchComplete:(ASIHTTPRequest *)theRequest
{
	BOOL success = ([request responseStatusCode] == 200);
	if(success){
		//retry the user info
		SBJSON *parser = [[SBJSON alloc] init];
		NSString *json_string = [[NSString alloc] initWithData:[theRequest responseData] encoding:NSUTF8StringEncoding];
		NSDictionary *statuses = [parser objectWithString:json_string error:nil];
		NSDictionary *eater = [statuses objectForKey:@"eater"];
		[LoggedUser setloggedUserID:[eater objectForKey:@"email"]];
		[self dismissModalViewControllerAnimated:TRUE];
	}
	else{
		//todo
	}	
}

- (IBAction)cancelAndGoToMain{
	[self dismissModalViewControllerAnimated:TRUE];	
	FirstViewController *firstViewController = [[FirstViewController alloc] initWithNibName:@"MainWindow" bundle:[NSBundle mainBundle]];
//    [self.parentViewController navigationController pushViewController:firstViewController animated:TRUE];
    [self.parentViewController.navigationController pushViewController:firstViewController animated:TRUE];
    [firstViewController release];
}

- (void)viewDidLoad {
	responseField.hidden = YES;
	restUtil = [[[RestUtil alloc] init] retain ];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	[request release];
	[userName release];
	[password release];
	[login release];
	[responseField release];
	[cancel release];
	[restUtil release];
	[super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}


@end
