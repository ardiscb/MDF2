//
//  CustomCellController.m
//  TwitterPractice
//
//  Created by Courtney Ardis on 6/4/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import "CustomCellController.h"

@implementation CustomCellController
@synthesize tweetLabel, dateLabel, profileImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
