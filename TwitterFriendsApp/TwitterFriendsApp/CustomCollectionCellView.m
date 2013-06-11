//
//  CustomCollectionCellView.m
//  TwitterFriendsApp
//
//  Created by Courtney Ardis on 6/10/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import "CustomCollectionCellView.h"

@implementation CustomCollectionCellView
@synthesize avatarImageView, screenNameLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)refreshCellData:(UIImage*)image nameString:(NSString*)nameString
{
    avatarImageView.image = image;
    screenNameLabel.text = nameString;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
