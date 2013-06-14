//
//  ViewController.h
//  TwitterFriendsApp
//
//  Created by Courtney Ardis on 6/10/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "FollowerInfo.h"

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    IBOutlet UICollectionView *friendsCollectionView;
    NSDictionary *friendsDictionary;
    NSString *name;
    NSMutableArray *infoStorage;
    NSArray *followersArray;
    
    UIAlertView *loadCollectionAlert;
    
    FollowerInfo *info;
}

@property FollowerInfo *info;
@end
