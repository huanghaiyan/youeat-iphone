//
//  RestUtil.h
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RestUtil : NSObject {
	
	NSString *connectionURL;
}

@property (nonatomic, retain) IBOutlet NSString *connectionURL;

- (NSDictionary*) sendRestRequest:(NSString*)url;

@end
