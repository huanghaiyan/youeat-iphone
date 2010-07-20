//
//  RistoViewScrollController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 7/20/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RistoScrollViewController : UIViewController  <UIScrollViewDelegate> {
	UIWindow *window;
	UIScrollView *scrollView;
	UIPageControl *pageControl;
    NSMutableArray *viewControllers;
	NSDictionary *selectedRisto;
    // To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
}

@property (nonatomic, retain) NSDictionary *selectedRisto;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;

- (IBAction)changePage:(id)sender;

@end

