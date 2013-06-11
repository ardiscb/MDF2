//
//  FollowerInfo.m
//  TwitterFriendsApp
//
//  Created by Courtney Ardis on 6/10/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import "FollowerInfo.h"

@implementation FollowerInfo
@synthesize avatarImages, screenNames;

-(id)initWithInfo:(NSString*)names images:(UIImage*)followerImage
{
    if((self = [super init]))
    {
        avatarImages = followerImage;
        screenNames = names;
    }
    return self;
}
@end
