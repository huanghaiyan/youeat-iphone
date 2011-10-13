//
//  JKCustomAlert.m
//  CustomAlert
//
//  Created by Joris Kluivers on 4/2/09.
//  Copyright 2009 Tarento Software Solutions & Projects. All rights reserved.
//

#import "JKCustomAlert.h"


@implementation JKCustomAlert

@synthesize backgroundImage, alertText, activityView;

- (id)initWithImage:(UIImage *)image text:(NSString *)text delegate:(id)delegate{
    if (self = [super init]) {
		alertTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		alertTextLabel.textColor = [UIColor grayColor];
		alertTextLabel.backgroundColor = [UIColor clearColor];
		alertTextLabel.font = [UIFont systemFontOfSize:15];
		[self addSubview:alertTextLabel];
        self.backgroundImage = image;
		self.alertText = text;
        
        self.activityView = [[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(252, 14, 10, 10)] autorelease];
		[self addSubview:activityView];
		activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
		[activityView startAnimating];
    }
    return self;
}

- (void) setAlertText:(NSString *)text {
	alertTextLabel.text = text;
}

- (NSString *) alertText {
	return alertTextLabel.text;
}


- (void)drawRect:(CGRect)rect {
    //CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	CGSize imageSize = self.backgroundImage.size;
	//CGContextDrawImage(ctx, CGRectMake(0, 0, imageSize.width, imageSize.height), self.backgroundImage.CGImage);
	[self.backgroundImage drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
}

- (void) layoutSubviews {
    for (UIView *sub in [self subviews])
	{
		if([sub class] == [UIImageView class] && sub.tag == 0)
		{
			// The alert background UIImageView tag is 0, 
			// if you are adding your own UIImageView's 
			// make sure your tags != 0 or this fix 
			// will remove your UIImageView's as well!
			[sub removeFromSuperview];
			break;
		}
	}
	alertTextLabel.transform = CGAffineTransformIdentity;
	[alertTextLabel sizeToFit];
	
	CGRect textRect = alertTextLabel.frame;
	textRect.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(textRect)) / 2;
	textRect.origin.y = (CGRectGetHeight(self.bounds) - CGRectGetHeight(textRect)) / 2;
	textRect.origin.y -= 30.0;
	
	alertTextLabel.frame = textRect;
	
}

- (void) show {
	[super show];
	
	CGSize imageSize = self.backgroundImage.size;
	self.bounds = CGRectMake(0, 0, imageSize.width, imageSize.height);
}


- (void)dealloc {
    [activityView release];
    [super dealloc];
}


@end
