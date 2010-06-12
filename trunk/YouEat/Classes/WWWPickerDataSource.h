//
//  WWWPickerDataSource.h
//  YouEat
//
//  Created by Alessandro Vincelli on 6/6/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WWWPickerDataSource : NSObject <UIPickerViewDataSource, UIPickerViewDelegate>
{
	NSArray	*wwwPickerArray;
}

@property (nonatomic, retain) NSArray *wwwPickerArray;

@end
