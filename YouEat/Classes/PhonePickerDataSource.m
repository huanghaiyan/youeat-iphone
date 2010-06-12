//
//  PhonePickerDataSource.m
//  YouEat
//
//  Created by Alessandro Vincelli on 6/9/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import "PhonePickerDataSource.h"


@implementation PhonePickerDataSource


@synthesize wwwPickerArray;

- (void)callRisto:(NSString*)numberToCall{
	NSString *composeNumberString = [numberToCall stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	composeNumberString = [composeNumberString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
	composeNumberString = [NSString stringWithFormat:@"tel:%@", composeNumberString];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:composeNumberString]];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	NSString *numberToCall = [[wwwPickerArray objectAtIndex:[pickerView selectedRowInComponent:0]] retain];
	[self callRisto: numberToCall];
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

