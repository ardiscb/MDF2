//
//  UserDetailViewController.m
//  TwitterPractice
//
//  Created by Courtney Ardis on 6/5/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import "ViewController.h"
#import "UserDetailViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface UserDetailViewController ()

@end

@implementation UserDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //User Profile Alert
    userProfileAlert = [[UIAlertView alloc] initWithTitle:@"Loading" message:@"Please wait while the user profile loads." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [userProfileAlert show];
    
    if(userProfileAlert != nil) {
        //show loading indicator
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        indicator.center = CGPointMake(userProfileAlert.bounds.size.width/2, userProfileAlert.bounds.size.height-45);
        [indicator startAnimating];
        [userProfileAlert addSubview:indicator];
        NSLog(@"alert showed");
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
                            NSString *userProfileString = [NSString stringWithFormat:@"https://api.twitter.com/1.1/users/show.json?screen_name=%@", currentAccount.username];
                            NSLog(@"Current Account:%@",currentAccount.username);
                            
                            //request URL
                            SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:userProfileString] parameters:nil];
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
                                        userProfile = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                      options:0
                                                                                        error:nil];
                                        if(userProfile != nil)
                                        {
                                            //get name from JSON and store in varilable:name
                                            NSString *name = [(NSDictionary*)userProfile objectForKey:@"name"];
                                            //get description from JSON and store in variable:userDescription
                                            NSString *userDescription = [(NSDictionary*)userProfile objectForKey:@"description"];
                                            //get # of followers from JSON and store in variable:followers
                                            int followers = [[(NSDictionary*)userProfile objectForKey:@"followers_count"] integerValue];
                                            //get # of friends from JSON and store in variable: friends
                                            int friends = [[(NSDictionary*)userProfile objectForKey:@"friends_count"] integerValue];
                                            
                                            //set labels to JSON values
                                            twitterName.text = name;
                                            description.text = userDescription;
                                            numFollowers.text = [NSString stringWithFormat:@"%d", followers];
                                            numFriends.text = [NSString stringWithFormat:@"%d", friends];
                                            
                                            //logs JSON data for logged in user
                                            NSLog(@"User Profile = %@", userProfile);
                                            NSLog(@"User Profile Name = %@", name);
                                            NSLog(@"User Description = %@", userDescription);
                                        }
                                    }
                                    else if(responseCode == 215)
                                    {
                                        NSLog(@"Errors:%@", errors);
                                    }
                                }];
                            }
                        }
                    }
                }
                else
                {
                    NSLog(@"User did not grant access");
                    
                    //alert user text field needs text and date
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter Account" message:@"There is no Twitter account logged in. Please go to Settings and log into your Twitter account." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    if(alert != nil)
                    {
                        //show alert
                        [alert show];
                    }
                }
            }];
        }
    }
    
    //delay alert closing
    [self performSelector:@selector(dismissAlertView:) withObject:userProfileAlert afterDelay:5.3];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
//dismiss alert after delay
-(void)dismissAlertView:(UIAlertView *)alertView
{
    //dismiss userProfileAlert view
    [userProfileAlert dismissWithClickedButtonIndex:0 animated:YES];
}

-(IBAction)onClick:(id)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
