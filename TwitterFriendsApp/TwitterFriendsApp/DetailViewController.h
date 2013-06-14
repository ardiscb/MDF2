//
//  DetailViewController.h
//  TwitterFriendsApp
//
//  Created by Courtney Ardis on 6/13/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowerInfo.h"

@interface DetailViewController : UIViewController
{
    IBOutlet UIImageView *avatarImageView;
    IBOutlet UILabel *screenNameLabel;
    IBOutlet UIButton *closeBtn;
    FollowerInfo *info;
}

@property FollowerInfo *info;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *screenNameLabel;

-(IBAction)onClick:(id)sender;

@end
