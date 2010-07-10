//
//  ASIRestUtil.h
//  YouEat
//
//  Created by Alessandro Vincelli on 7/7/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ASIRestUtil : NSObject {
	
	NSString *connectionURL;
}

@property (nonatomic, retain) IBOutlet NSString *connectionURL;

- (NSDictionary*) sendRestRequest:(NSString*)url;

@end