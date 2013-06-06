//
//  ViewController.m
//  TwitterPractice
//
//  Created by Courtney Ardis on 6/4/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import "ViewController.h"
#import "CustomCellController.h"
#import "TweetDetailViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

#define REFRESH 0
#define POST 1

@interface ViewController ()

@end

@implementation ViewController
//@synthesize handler, tweetText;
//@synthesize tweetDictionary;

- (void)viewDidLoad
{
    //set handler to nil
    //handler = nil;
    
    //Table Load Alert
    tableLoadAlert = [[UIAlertView alloc] initWithTitle:@"Loading" message:@"Please wait while your twitter feed loads." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [tableLoadAlert show];
    
    if(tableLoadAlert != nil) {
        //show loading indicator
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        indicator.center = CGPointMake(tableLoadAlert.bounds.size.width/2, tableLoadAlert.bounds.size.height-45);
        [indicator startAnimating];
        [tableLoadAlert addSubview:indicator];
    }
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    if(accountStore != nil)
    {
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        if(accountType != nil)
        {
            //request access
            [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *errors) {
                if (granted)
                {
                    // account by type - Twitter
                    NSArray *twitterAccounts = [accountStore accountsWithAccountType:accountType];
                    if(twitterAccounts != nil)
                    {
                        // twitter account currently logged in
                        ACAccount *currentAccount = [twitterAccounts objectAtIndex:0];
                        if(currentAccount != nil)
                        {
                            //string for NSURL in SLRequest
                            NSString *userTimelineString = @"https://api.twitter.com/1.1/statuses/user_timeline.json";
                            
                            //get other screen name twitter feed
                            //NSString *userTimelineString = [NSString stringWithFormat:@"%@?%@&%@", @"https://api.twitter.com/1.1/statuses/user_timeline.json", @"screen_name=fullsail", @"count=3"];
                            //request URL
                            SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:userTimelineString] parameters:nil];
                            if(request != nil)
                            {
                                //1.1 API requires a user to be logged in
                                //request for currentAccount - account that is logged in on device/sim
                                [request setAccount:currentAccount];
                                
                                //perform request
                                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                    
                                    NSInteger responseCode = [urlResponse statusCode];
                                    if(responseCode == 200)
                                    {
                                        twitterFeed = [NSJSONSerialization JSONObjectWithData:responseData
                                                       options:0
                                                       error:nil];
                                        if(twitterFeed != nil)
                                        {
                                            //causes table view to trigger a reload
                                            [twitterTableView reloadData];
                                            NSLog(@"%@", [twitterFeed description]);
                                        }
                                    }
                                }];
                            }
                        }
                    }
                }
                else
                {
                    NSLog(@"User did not grant access");
                    
                    /////THIS ALERT IS NOT SHOWING - NEED TO FIX/////
                    //alert user text field needs text and date
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter Account" message:@"There is no Twitter account logged in. Please go to Settings and log into your Twitter account." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
                    if(alert != nil)
                    {
                        //show alert
                        [alert show];
                    }
                }
             }];
        }
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(twitterFeed != nil)
    {
        //returns total number of tweets within array
        return [twitterFeed count];
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return height of custom cell
    return 63;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCellView" owner:self options:nil];
    CustomCellController *cell = (CustomCellController *) [nib objectAtIndex:0];
    if(cell != nil)
    {
        tweetDictionary = [twitterFeed objectAtIndex:indexPath.row];
        
        //IMAGE DOESN'T CHANGE FOR EACH CELL//
        //add image to custom cells
        NSString *imageURL = [[tweetDictionary objectForKey:@"user"] objectForKey:@"profile_image_url"];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
        
        //format date
        dateFormatter = [[NSDateFormatter alloc] init];
        
        if(dateFormatter != nil)
        {
            NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            [dateFormatter setLocale:usLocale];
            //format date
            [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
            tweetDate = [dateFormatter dateFromString:[tweetDictionary objectForKey:@"created_at"]];
            //set formatted date
            [dateFormatter setDateStyle:NSDateFormatterLongStyle];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
            formattedDate = [dateFormatter stringFromDate:tweetDate];

            NSLog(@"Formatted Date = %@", formattedDate);
            NSLog(@"Tweet Date = %@", tweetDate);
        }

        
        if(tweetDictionary != nil)
        {
            //dismiss loading alert
            [tableLoadAlert dismissWithClickedButtonIndex:0 animated:YES];
            
            //load cells with data
            tweetText = (NSString*)[tweetDictionary objectForKey:@"text"];
            //set cell text to the text from the tweet
            cell.tweetLabel.text = tweetText;
            //set cell date text to the date from the tweet
            cell.dateLabel.text = formattedDate;
            //set imageView image to the profile image url from the tweet            
            cell.profileImage.image = [UIImage imageWithData:imageData];
            return cell;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //present twitter detail view
    TweetDetailViewController *tweetDetailView = [[TweetDetailViewController alloc] initWithNibName:@"TweetDetailViewController" bundle:nil];
    if(tweetDetailView != nil)
    {
//        handler = ^(NSString* text)
//        {
//        };
        
        //Create an NSDictionary from the twitter array
        NSDictionary *tweetData = [twitterFeed objectAtIndex:indexPath.row];
        NSLog(@"Tweet Data = %@", tweetData);
        //Pass the tweetData dictionary to the detail view
        tweetDetailView.twitterData = tweetData;
        [self presentViewController:tweetDetailView animated:true completion:nil];
    }
}


-(IBAction)onClick:(id)sender
{
    UIButton *button = (UIButton*)sender;
    if(button.tag == REFRESH)
    {
        //Refresh Alert
        refreshAlert = [[UIAlertView alloc] initWithTitle:@"Refreshing" message:@"Please wait while your twitter feed refreshes." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [refreshAlert show];
        
        if(refreshAlert != nil) {
            //show loading indicator
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            
            indicator.center = CGPointMake(refreshAlert.bounds.size.width/2, refreshAlert.bounds.size.height-45);
            [indicator startAnimating];
            [refreshAlert addSubview:indicator];
        }
        
        //There has to be a different way to reload the table.
        //reload table view        
        ACAccountStore *accountStore = [[ACAccountStore alloc] init];
        if(accountStore != nil)
        {
            ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
            if(accountType != nil)
            {
                //request access
                [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *errors) {
                    if (granted)
                    {
                        // account by type - Twitter
                        NSArray *twitterAccounts = [accountStore accountsWithAccountType:accountType];
                        if(twitterAccounts != nil)
                        {
                            // twitter account currently logged in
                            ACAccount *currentAccount = [twitterAccounts objectAtIndex:0];
                            if(currentAccount != nil)
                            {
                                //string for NSURL in SLRequest
                                NSString *userTimelineString = @"https://api.twitter.com/1.1/statuses/user_timeline.json";
                                
                                //get other screen name twitter feed
                                //NSString *userTimelineString = [NSString stringWithFormat:@"%@?%@&%@", @"https://api.twitter.com/1.1/statuses/user_timeline.json", @"screen_name=fullsail", @"count=3"];
                                //request URL
                                SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:userTimelineString] parameters:nil];
                                if(request != nil)
                                {
                                    //1.1 API requires a user to be logged in
                                    //request for currentAccount - account that is logged in on device/sim
                                    [request setAccount:currentAccount];
                                    
                                    //perform request
                                    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                        
                                        NSInteger responseCode = [urlResponse statusCode];
                                        if(responseCode == 200)
                                        {
                                            twitterFeed = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                          options:0
                                                                                            error:nil];
                                            if(twitterFeed != nil)
                                            {
                                                //causes table view to trigger a reload
                                                //doesn't load in new data on its own
                                                [twitterTableView reloadData];
                                                NSLog(@"%@", [twitterFeed description]);
                                                
                                                [refreshAlert dismissWithClickedButtonIndex:0 animated:true];

                                            }
                                        }
                                    }];
                                }
                            }
                        }
                    }
                    else
                    {
                        NSLog(@"User did not grant access");
                        
                        /////THIS ALERT IS NOT SHOWING - NEED TO FIX/////
                        //alert user text field needs text and date
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter Account" message:@"There is no Twitter account logged in. Please go to Settings and log into your Twitter account." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
                        if(alert != nil)
                        {
                            //show alert
                            [alert show];
                        }
                    }
                }];
            }
        }
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
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
