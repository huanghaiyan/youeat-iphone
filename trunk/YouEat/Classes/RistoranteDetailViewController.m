//
//  RistoranteDetailViewController.m
//  YouEat
//
//  Created by Alessandro Vincelli on 10/04/10.
//  Copyright 2010 Alessandro Vincelli. All rights reserved.
//

#import "RistoranteDetailViewController.h"
#import "Annotation.h"

@implementation RistoranteDetailViewController

@synthesize selectedRisto, mapView, ristoDataCell, address, description, tags, phone, ristoranteName;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];

	self.address.text = [NSString stringWithFormat:@"%@, %@", [[selectedRisto objectForKey:@"city"] objectForKey:@"name"], [selectedRisto objectForKey:@"address"]];	
	self.navigationItem.title = @"Selected restaurant";

	NSString *phoneText = [selectedRisto objectForKey:@"phoneNumber"];
	if (phoneText == [NSNull null] || phoneText.length == 0 ) {
		phoneText = @"";
	}
	else{	
		phoneText = [phoneText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		phoneText = [phoneText stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
		//NSNumberFormatter *formatter=[[NSNumberFormatter alloc] init];
		//[formatter setPositiveFormat:@"+# (###) ###-####"];
		//phoneText = [formatter stringForObjectValue:[NSNumber numberWithInt:phoneText]];
	}
	
	self.phone.titleLabel.text = phoneText;	
	self.phone.titleLabel.adjustsFontSizeToFitWidth = TRUE;
	[self.phone addTarget:self action:@selector(callRisto:) forControlEvents:UIControlEventTouchUpInside];
	
	NSDictionary *descriptions = [selectedRisto objectForKey:@"descriptions"] ;	
	NSEnumerator *descriptionEnum = [descriptions objectEnumerator];
	NSString *descriptionText = @"";	
	NSDictionary *object;
	while ((object = [descriptionEnum nextObject])) {
		descriptionText = [descriptionText stringByAppendingString:[object objectForKey:@"description"]];
	}
	self.description.text = descriptionText;
	
	NSDictionary *tagsList = [selectedRisto objectForKey:@"tags"];	
	NSEnumerator *tagEnum = [tagsList objectEnumerator];
	NSString *tagText = @"";	
	NSDictionary *tagObject;
	while ((tagObject = [tagEnum nextObject])) {
		tagText = [tagText stringByAppendingString:[tagObject objectForKey:@"tag"]];
		tagText = [tagText stringByAppendingString:@" "];
	}
	self.tags.text = tagText;	
	
	// Set the map
    MKCoordinateRegion region;
    region.center.latitude = [[selectedRisto objectForKey:@"latitude"] doubleValue] ;
    region.center.longitude = [[selectedRisto objectForKey:@"longitude"] doubleValue] ;
	
	MKCoordinateSpan span = {0.002, 0.002};
    region.span = span;
    [self.mapView setRegion:region animated:YES];
	CLLocationCoordinate2D pinlocation=mapView.userLocation.coordinate;
	pinlocation.latitude = [[selectedRisto objectForKey:@"latitude"] doubleValue] ;
    pinlocation.longitude = [[selectedRisto objectForKey:@"longitude"] doubleValue] ;

    Annotation *annotation = [[Annotation alloc] initWithCoordinate:pinlocation ];
    [self.mapView addAnnotation:annotation];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
	[ristoranteName release];
	[selectedRisto release];
	[ristoDataCell release];
	[address release];
	[tags release];
	[description release];
	[phone release];
}


- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // handle our two custom annotations
    //
        // try to dequeue an existing pin view first
        static NSString* BridgeAnnotationIdentifier = @"bridgeAnnotationIdentifier";
        MKPinAnnotationView* pinView = (MKPinAnnotationView *)
		[mapView dequeueReusableAnnotationViewWithIdentifier:BridgeAnnotationIdentifier];
        if (!pinView)
        {
            // if an existing pin view was not available, create one
            MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc]
												   initWithAnnotation:annotation reuseIdentifier:BridgeAnnotationIdentifier] autorelease];
            customPinView.pinColor = MKPinAnnotationColorPurple;
            customPinView.animatesDrop = YES;
            customPinView.canShowCallout = YES;
            
            // add a detail disclosure button to the callout which will open a new view controller page
            //
            // note: you can assign a specific call out accessory view, or as MKMapViewDelegate you can implement:
            //  - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
            //
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:self
                            action:@selector(showDetails:)
                  forControlEvents:UIControlEventTouchUpInside];
            customPinView.rightCalloutAccessoryView = rightButton;
			
            return customPinView;
		}
        return pinView;
}

- (void)callRisto:(id)sender{
	NSString *composeNumberString = [selectedRisto objectForKey:@"phoneNumber"];
	composeNumberString = [composeNumberString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	composeNumberString = [composeNumberString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
	composeNumberString = [NSString stringWithFormat:@"tel:%@", composeNumberString];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:composeNumberString]];
}
@end
