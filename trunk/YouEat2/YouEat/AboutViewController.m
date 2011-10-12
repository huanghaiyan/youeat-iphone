//
//  AboutViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 10/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController

@synthesize myWebView;

-(void)loadDocument:(NSString*)documentName inView:(UIWebView*)webView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
	webFrame.size.height -= 100.0;
	self.myWebView = [[[UIWebView alloc] initWithFrame:webFrame] autorelease];
    [myWebView setDelegate: self];
	[self loadDocument:@"about.html" inView:self.myWebView];
	[self.view addSubview: self.myWebView];	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
	[myWebView release];
    [super dealloc];
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    return YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return NO;
}

@end
