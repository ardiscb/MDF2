//
//  TweetDetailViewController.h
//  TwitterPractice
//
//  Created by Courtney Ardis on 6/4/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetDetailViewController : UIViewController
{
    NSDate *tweetDate;
    NSDateFormatter *dateFormatter;
    NSString *formattedDate;
    
    IBOutlet UIButton *userProfileBtn;
    
    IBOutlet UITextView *tweetText;
    IBOutlet UILabel *date;
    IBOutlet UILabel *userName;
}

-(IBAction)onClick:(id)sender;
@property (nonatomic, strong)NSDictionary *twitterData;
@end
