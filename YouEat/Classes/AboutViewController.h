//
//  AboutViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 6/26/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutViewController : UIViewController <UIWebViewDelegate> {
	UIWebView *myWebView;
}

@property (nonatomic, retain) IBOutlet UIWebView *myWebView;

@end
