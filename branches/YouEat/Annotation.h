//
//  Annotation.h
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>{
	CLLocationCoordinate2D coordinate;
	NSString *currentSubTitle;
	NSString *currentTitle;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *currentTitle;
@property (nonatomic, retain) NSString *currentSubTitle;

- (NSString *)title;
- (NSString *)subtitle;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c;


@end