//
//  AboutViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 6/26/10.
//  Copyright 2010 ICTU. All rights reserved.
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
	webFrame.origin.y += 5.0 + 5.0;	// leave from the URL input field and its label
	webFrame.size.height -= 40.0;
	self.myWebView = [[[UIWebView alloc] initWithFrame:webFrame] autorelease];
	[self loadDocument:@"data.html" inView:self.myWebView];
	
	[self.view addSubview: self.myWebView];	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
	[myWebView dealloc];
    [super dealloc];
}

@end
