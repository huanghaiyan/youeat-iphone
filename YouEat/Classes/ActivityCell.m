//
//  ActivityCell.m
//  YouEat
//
//  Created by Alessandro Vincelli on 7/13/10.
//  Copyright 2010 ICTU. All rights reserved.
//

#import "ActivityCell.h"

@interface ActivityCell (SubviewFrames)
- (CGRect)_imageViewFrame;
- (CGRect)_nameLabelFrame;
- (CGRect)_descriptionLabelFrame;
- (CGRect)_cityLabelFrame;
- (CGRect)_timeLabelFrame;
@end


#pragma mark -
#pragma mark RecipeTableViewCell implementation

@implementation ActivityCell

@synthesize imageView, nameLabel, overviewLabel, cityLabel, timeLabel;


#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:imageView];
		
        overviewLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [overviewLabel setFont:[UIFont systemFontOfSize:9.0]];
        [overviewLabel setTextColor:[UIColor darkGrayColor]];
        [overviewLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:overviewLabel];
		
        cityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        cityLabel.textAlignment = UITextAlignmentRight;
        [cityLabel setFont:[UIFont systemFontOfSize:8.0]];
        [cityLabel setTextColor:[UIColor blackColor]];
        [cityLabel setHighlightedTextColor:[UIColor whiteColor]];
		cityLabel.minimumFontSize = 8.0;
		cityLabel.lineBreakMode = UILineBreakModeTailTruncation;
        [self.contentView addSubview:cityLabel];
		
        nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [nameLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [nameLabel setTextColor:[UIColor blackColor]];
        [nameLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:nameLabel];
		
		timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        timeLabel.textAlignment = UITextAlignmentRight;
        [timeLabel setFont:[UIFont systemFontOfSize:8.0]];
        [timeLabel setTextColor:[UIColor blackColor]];
        [timeLabel setHighlightedTextColor:[UIColor whiteColor]];
		timeLabel.minimumFontSize = 8.0;
		timeLabel.lineBreakMode = UILineBreakModeTailTruncation;
        [self.contentView addSubview:timeLabel];
    }
	
    return self;
}


#pragma mark -
#pragma mark Laying out subviews

/*
 To save space, the prep time label disappears during editing.
 */
- (void)layoutSubviews {
    [super layoutSubviews];
	
    [imageView setFrame:[self _imageViewFrame]];
    [nameLabel setFrame:[self _nameLabelFrame]];
    [overviewLabel setFrame:[self _descriptionLabelFrame]];
    [timeLabel setFrame:[self _timeLabelFrame]];
    [cityLabel setFrame:[self _cityLabelFrame]];
}


#define IMAGE_SIZE          32.0
#define EDITING_INSET       10.0
#define TEXT_LEFT_MARGIN    8.0
#define TEXT_RIGHT_MARGIN   5.0
#define CITY_WIDTH     60.0

/*
 Return the frame of the various subviews 
 */
- (CGRect)_imageViewFrame {
	return CGRectMake(5.0, 5.0, IMAGE_SIZE, IMAGE_SIZE);
}

- (CGRect)_descriptionLabelFrame {
    return CGRectMake(IMAGE_SIZE + TEXT_LEFT_MARGIN, 4.0, self.contentView.bounds.size.width - IMAGE_SIZE - TEXT_RIGHT_MARGIN * 2 - CITY_WIDTH, 16.0);
}

- (CGRect)_nameLabelFrame {
    return CGRectMake(IMAGE_SIZE + TEXT_LEFT_MARGIN, 22.0, self.contentView.bounds.size.width - IMAGE_SIZE - TEXT_LEFT_MARGIN * 2 - CITY_WIDTH, 16.0);
}

- (CGRect)_timeLabelFrame {
    CGRect contentViewBounds = self.contentView.bounds;
    return CGRectMake(contentViewBounds.size.width - CITY_WIDTH - TEXT_RIGHT_MARGIN, 5.0, CITY_WIDTH, 8.0);
}

- (CGRect)_cityLabelFrame {
    CGRect contentViewBounds = self.contentView.bounds;
    return CGRectMake(contentViewBounds.size.width - CITY_WIDTH - TEXT_RIGHT_MARGIN, 25, CITY_WIDTH, 9.0);
}




#pragma mark -
#pragma mark Recipe set accessor

- (void)dealloc {
    [imageView release];
    [nameLabel release];
    [overviewLabel release];
    [cityLabel release];
	[timeLabel release];
    [super dealloc];
}

@end
