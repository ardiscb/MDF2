//
//  CustomCollectionCellView.h
//  TwitterFriendsApp
//
//  Created by Courtney Ardis on 6/10/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "FollowerInfo.h"

@interface CustomCollectionCellView : UICollectionViewCell
{
    IBOutlet UIImageView *avatarImageView;
    IBOutlet UILabel *screenNameLabel;
}

-(void)refreshCellData:(UIImage*)image nameString:(NSString*)nameString;

@property (nonatomic, strong)UIImageView *avatarImageView;
@property (nonatomic, strong)UILabel *screenNameLabel;
@property FollowerInfo *info;
@end
