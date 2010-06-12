//
//  PhonePickerDataSource.h
//  YouEat
//
//  Created by Alessandro Vincelli on 6/9/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PhonePickerDataSource : NSObject <UIPickerViewDataSource, UIPickerViewDelegate>
{
	NSArray	*wwwPickerArray;
}

@property (nonatomic, retain) NSArray *wwwPickerArray;

- (void)callRisto:(NSString*)numberToCall;

@end
