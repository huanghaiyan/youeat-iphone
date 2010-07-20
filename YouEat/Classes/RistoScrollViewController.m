//
//  RistoViewScrollController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 7/20/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import "RistoScrollViewController.h"
#import "RistoViewController.h"
#import "RistoMapViewController.h"

static NSUInteger kNumberOfPages = 2;

@interface RistoScrollViewController (PrivateMethods)

- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;

@end

@implementation RistoScrollViewController

@synthesize window, scrollView, pageControl, viewControllers, selectedRisto;

- (void)dealloc {
    [viewControllers release];
    [scrollView release];
    [pageControl release];
    [window release];
	[selectedRisto release];
    [super dealloc];
}

- (void)viewDidLoad {
    // view controllers are created lazily
    // in the meantime, load the array with placeholders which will be replaced on demand
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfPages; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    [controllers release];
	
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
	
    pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = 0;
	
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
}

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= kNumberOfPages) return;
	UIViewController *controller;

	if(page == 0){
		// replace the placeholder if necessary
		RistoViewController *ristoViewcontroller = [viewControllers objectAtIndex:page];
		if ((NSNull *)ristoViewcontroller == [NSNull null]) {
			ristoViewcontroller = [[RistoViewController alloc] initWithNibName:@"RistoView" bundle:[NSBundle mainBundle]];
			ristoViewcontroller.selectedRisto = selectedRisto;
			[viewControllers replaceObjectAtIndex:page withObject:ristoViewcontroller];
			[ristoViewcontroller release];
		}
		controller = ristoViewcontroller;
	}
	
	if(page == 1){
		// replace the placeholder if necessary
		RistoMapViewController *ristoMapViewcontroller = [viewControllers objectAtIndex:page];
		if ((NSNull *)ristoMapViewcontroller == [NSNull null]) {
			ristoMapViewcontroller = [[RistoViewController alloc] initWithNibName:@"RistoMapViewController" bundle:[NSBundle mainBundle]];
			ristoMapViewcontroller.selectedRisto = selectedRisto;
			[viewControllers replaceObjectAtIndex:page withObject:ristoMapViewcontroller];
			[ristoMapViewcontroller release];
		}
		controller = ristoMapViewcontroller;
	}


	// add the controller's view to the scroll view
	if (nil == controller.view.superview) {
		CGRect frame = scrollView.frame;
		frame.origin.x = frame.size.width * page;
		frame.origin.y = 0;
		controller.view.frame = frame;
		[scrollView addSubview:controller.view];
	}

}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
	
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}

@end
