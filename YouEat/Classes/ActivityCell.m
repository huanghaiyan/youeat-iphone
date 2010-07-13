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
- (CGRect)_prepTimeLabelFrame;
@end


#pragma mark -
#pragma mark RecipeTableViewCell implementation

@implementation ActivityCell

@synthesize imageView, nameLabel, overviewLabel, prepTimeLabel;


#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:imageView];
		
        overviewLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [overviewLabel setFont:[UIFont systemFontOfSize:12.0]];
        [overviewLabel setTextColor:[UIColor darkGrayColor]];
        [overviewLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:overviewLabel];
		
        prepTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        prepTimeLabel.textAlignment = UITextAlignmentRight;
        [prepTimeLabel setFont:[UIFont systemFontOfSize:12.0]];
        [prepTimeLabel setTextColor:[UIColor blackColor]];
        [prepTimeLabel setHighlightedTextColor:[UIColor whiteColor]];
		prepTimeLabel.minimumFontSize = 7.0;
		prepTimeLabel.lineBreakMode = UILineBreakModeTailTruncation;
        [self.contentView addSubview:prepTimeLabel];
		
        nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [nameLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [nameLabel setTextColor:[UIColor blackColor]];
        [nameLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:nameLabel];
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
    [prepTimeLabel setFrame:[self _prepTimeLabelFrame]];
}


#define IMAGE_SIZE          32.0
#define EDITING_INSET       10.0
#define TEXT_LEFT_MARGIN    8.0
#define TEXT_RIGHT_MARGIN   5.0
#define PREP_TIME_WIDTH     80.0

/*
 Return the frame of the various subviews -- these are dependent on the editing state of the cell.
 */
- (CGRect)_imageViewFrame {
	return CGRectMake(5.0, 5.0, IMAGE_SIZE, IMAGE_SIZE);
}

- (CGRect)_nameLabelFrame {
    return CGRectMake(IMAGE_SIZE + TEXT_LEFT_MARGIN, 4.0, self.contentView.bounds.size.width - IMAGE_SIZE - TEXT_RIGHT_MARGIN * 2 - PREP_TIME_WIDTH, 16.0);
}

- (CGRect)_descriptionLabelFrame {
    return CGRectMake(IMAGE_SIZE + TEXT_LEFT_MARGIN, 22.0, self.contentView.bounds.size.width - IMAGE_SIZE - TEXT_LEFT_MARGIN, 16.0);
}

- (CGRect)_prepTimeLabelFrame {
    CGRect contentViewBounds = self.contentView.bounds;
    return CGRectMake(contentViewBounds.size.width - PREP_TIME_WIDTH - TEXT_RIGHT_MARGIN, 4.0, PREP_TIME_WIDTH, 16.0);
}


#pragma mark -
#pragma mark Recipe set accessor

- (void)dealloc {
    [imageView release];
    [nameLabel release];
    [overviewLabel release];
    [prepTimeLabel release];
    [super dealloc];
}

@end
