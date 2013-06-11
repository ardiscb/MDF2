//
//  CustomCollectionCellView.m
//  TwitterFriendsApp
//
//  Created by Courtney Ardis on 6/10/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import "CustomCollectionCellView.h"

@implementation CustomCollectionCellView
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

@end
