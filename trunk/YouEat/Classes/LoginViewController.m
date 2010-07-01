//
//  LoginViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 6/30/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import "LoginViewController.h"
#import "ASIHTTPRequest.h"
#import "URLUtil.h"

@implementation LoginViewController

@synthesize request, userName, password, login, responseField;

- (IBAction)fetchTopSecretInformation
{
	[userName resignFirstResponder];
	[password resignFirstResponder];
	NSString *url = [URLUtil getConnectionUrl];
	[self setRequest:[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[url stringByAppendingString:@"/ristorantiSecurity"]]]];
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
		[self dismissModalViewControllerAnimated:TRUE];	}
	else{
		//todo
	}
	
}	

- (void)viewDidLoad {
	responseField.hidden = YES;
	UIButton *goButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[goButton setTitle:@"Go!" forState:UIControlStateNormal];
	[goButton sizeToFit];
	
	[goButton addTarget:self action:@selector(fetchTopSecretInformation) forControlEvents:UIControlEventTouchDown];
	[self.view addSubview: goButton];	
	
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
	[super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}


@end
