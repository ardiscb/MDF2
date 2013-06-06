//
//  TweetDetailViewController.m
//  TwitterPractice
//
//  Created by Courtney Ardis on 6/4/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "UserDetailViewController.h"
#import "ViewController.h"
#import <Social/Social.h>


#define BACK 0
#define POST 1
#define PROFILE 2

@interface TweetDetailViewController ()

@end

@implementation TweetDetailViewController
@synthesize twitterData;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //format date
    dateFormatter = [[NSDateFormatter alloc] init];
    
    if(dateFormatter != nil)
    {
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setLocale:usLocale];
        //format date
        [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
        tweetDate = [dateFormatter dateFromString:[twitterData objectForKey:@"created_at"]];
        //set formatted date
        [dateFormatter setDateStyle:NSDateFormatterLongStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        formattedDate = [dateFormatter stringFromDate:tweetDate];
        
        NSLog(@"Formatted Date = %@", formattedDate);
        NSLog(@"Tweet Date = %@", tweetDate);
    }
    
    NSString *name = [[twitterData objectForKey:@"user"]objectForKey:@"screen_name"];
    NSString *tweet = [twitterData objectForKey:@"text"];
    
    tweetText.text = tweet;
    userName.text = [NSString stringWithFormat:@"@%@", name];
    date.text = formattedDate;

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)onClick:(id)sender
{
    UIButton *button = (UIButton*)sender;
    if(button.tag == BACK)
    {
        [self dismissViewControllerAnimated:true completion:nil];
    }
    else if(button.tag == POST)
    {
        // allocate posting UI
        SLComposeViewController *slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        if(slComposeViewController != nil)
        {
            //set default text for posting
            [slComposeViewController setInitialText:@"\nPosted from TwitterApp"];
            //present posting UI
            [self presentViewController:slComposeViewController animated:true completion:nil];
        }
    }
    else if (button.tag == PROFILE)
    {
        UserDetailViewController *userDetailView = [[UserDetailViewController alloc] initWithNibName:@"UserDetailViewController" bundle:nil];
        if(userDetailView != nil)
        {
            //present user profile view
            [self presentViewController:userDetailView animated:true completion:nil];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
