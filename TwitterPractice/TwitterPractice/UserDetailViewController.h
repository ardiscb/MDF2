//
//  UserDetailViewController.h
//  TwitterPractice
//
//  Created by Courtney Ardis on 6/5/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailViewController : UIViewController
{
    IBOutlet UIButton *closeBtn;
    
    NSArray *userProfile;
    NSDictionary *userDictionary;
    NSString *tweetText;
    
    IBOutlet UILabel *twitterName;
    IBOutlet UILabel *description;
    IBOutlet UILabel *numFollowers;
    IBOutlet UILabel *numFriends;
    
    UIAlertView *userProfileAlert;
}

-(void)dismissAlertView:(UIAlertView *)alertView;
-(IBAction)onClick:(id)sender;
@end
