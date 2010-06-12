//
//  RistoViewController.h
//  YouEat
//
//  Created by Alessandro Vincelli on 02/05/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "WWWPickerDataSource.h";
#import "PhonePickerDataSource.h";

@interface RistoViewController : UIViewController {
	
	UILabel *ristoranteName;
	UILabel *tags;
	UILabel *address;
	UITextView *description;
	NSDictionary *selectedRisto;
	MKMapView *mapView;
	UISegmentedControl *buttonBarSegmentedControl;
	UIView *currentPicker;
	NSInteger currentPicker2;
	UIPickerView *wwwPickerView;
	UIPickerView *phonePickerView;
	WWWPickerDataSource *wwwPickerDataSource;
	PhonePickerDataSource *phonePickerDataSource;
}

@property (nonatomic, retain) NSDictionary *selectedRisto;
@property (nonatomic, retain) IBOutlet UILabel *address;
@property (nonatomic, retain) IBOutlet UILabel *tags;
@property (nonatomic, retain) IBOutlet UILabel *ristoranteName;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UITextView * description;
@property (nonatomic, retain) IBOutlet UISegmentedControl *buttonBarSegmentedControl;
@property (nonatomic, retain) UIView *currentPicker;
@property (nonatomic, retain) UIPickerView *wwwPickerView;
@property (nonatomic, retain) UIPickerView *phonePickerView;
@property (nonatomic, retain) WWWPickerDataSource *wwwPickerDataSource;
@property (nonatomic, retain) PhonePickerDataSource *phonePickerDataSource;
//@property (nonatomic, retain) NSInteger currentPicker2;

- (IBAction)togglePickers:(id)sender;		// for changing between UIPickerView, UIDatePickerView and custom picker

@end
