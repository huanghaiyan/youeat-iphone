//
//  AccountViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 6/29/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import "AccountViewController.h"
#import "ASIHTTPRequest.h"
#import "LoginViewController.h"

@implementation AccountViewController;
@synthesize request, responseField;

- (IBAction)fetchTopSecretInformation
{
	[self setRequest:[ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8080/rest/ristorantiSecurity"]]];
//	[request setUseKeychainPersistence:YES];
	[request setDelegate:self];
	[request setShouldPresentAuthenticationDialog:FALSE];
	[[self request] setUsername:@"a.vincelli@gmail.com"];
	[[self request] setPassword:@"14asd03aa"];
	[request setDidFinishSelector:@selector(topSecretFetchComplete:)];
	[request setDidFailSelector:@selector(topSecretFetchFailed:)];
	[request startAsynchronous];
}

- (IBAction)topSecretFetchFailed:(ASIHTTPRequest *)theRequest
{
	[self showLogin];
	[responseField setText:[[request error] localizedDescription]];
	[responseField setFont:[UIFont boldSystemFontOfSize:12]];
}

- (IBAction)topSecretFetchComplete:(ASIHTTPRequest *)theRequest
{
	BOOL success = ([request responseStatusCode] == 200);
	if(success){
		[responseField setText:[request responseString]];
		[responseField setFont:[UIFont boldSystemFontOfSize:12]];
	}
	else{
		[self showLogin];
	}

}	

- (void)viewDidLoad {
		[self showLogin];
	responseField = [[[UITextView alloc] initWithFrame:CGRectZero] autorelease];
	[responseField setBackgroundColor:[UIColor clearColor]];
	[responseField setText:@"Secret information will appear here if authentication succeeds"];
	[responseField setFrame:CGRectMake(5,5,120,150)];
	[self.view addSubview: responseField];	
	
	UIButton *goButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[goButton setTitle:@"Go!" forState:UIControlStateNormal];
	[goButton sizeToFit];
	//[goButton setFrame:CGRectMake([view frame].size.width-[goButton frame].size.width+10,7,[goButton frame].size.width,[goButton frame].size.height)];
	
	[goButton addTarget:self action:@selector(fetchTopSecretInformation) forControlEvents:UIControlEventTouchDown];
	[self.view addSubview: goButton];	
	
}

- (void)showLogin{
	LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
	[self setModalTransitionStyle:UIModalPresentationFormSheet];
    [self presentModalViewController:loginViewController animated:YES];
    [loginViewController release];
}

@end
