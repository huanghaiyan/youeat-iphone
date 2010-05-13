//
//  Annotation.m
//  YouEat
//
//  Created by Alessandro Vincelli on 12/04/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import "Annotation.h"
#import <MapKit/MapKit.h>


@implementation Annotation

@synthesize coordinate;
@synthesize currentTitle;
@synthesize currentSubTitle;



- (NSString *)subtitle{
	return currentSubTitle;
}

- (NSString *)title{
	//	NSLog(@"currenttitle: %@",currentTitle);
	return currentTitle;//  @"Marker Annotation";
}


-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	
	//NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}
@end