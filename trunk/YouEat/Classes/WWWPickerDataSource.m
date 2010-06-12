//
//  WWWPickerDataSource.m
//  YouEat
//
//  Created by Alessandro Vincelli on 6/6/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import "WWWPickerDataSource.h"


@implementation WWWPickerDataSource

@synthesize wwwPickerArray;

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	NSString *www = [[wwwPickerArray objectAtIndex:[pickerView selectedRowInComponent:0]] retain];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:www]];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *returnStr = @"";
	returnStr = [wwwPickerArray objectAtIndex:row];
	return returnStr;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	return 270.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [wwwPickerArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}


- (void)dealloc
{
	[wwwPickerArray release];
	[super dealloc];
}

@end
