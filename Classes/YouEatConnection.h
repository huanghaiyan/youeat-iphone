//
//  YouEatConnection.h
//  YouEat
//
//  Created by Alessandro Vincelli on 10/04/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YouEatConnection : NSObject{
}

- (NSDictionary*) sendRequest:(NSString *)url;

@end
