//
//  FollowerInfo.h
//  TwitterFriendsApp
//
//  Created by Courtney Ardis on 6/10/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FollowerInfo : NSObject
{
    UIImage *avatarImages;
    NSString *screenNames;
}

@property (nonatomic, strong)UIImage *avatarImages;
@property (nonatomic, strong)NSString *screenNames;

-(id)initWithInfo:(NSString*)names images:(UIImage*)followerImage;
@end
