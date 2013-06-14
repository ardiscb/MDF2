//
//  ViewController.m
//  TwitterFriendsApp
//
//  Created by Courtney Ardis on 6/10/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionCellView.h"
#import "FollowerInfo.h"
#import "Reachability.h"
#import "DetailViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize info;

- (void)viewDidLoad
{
    //collection view load alert
    loadCollectionAlert = [[UIAlertView alloc] initWithTitle:@"Loading" message:@"Please wait while your twitter friends load." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [loadCollectionAlert show];
    
    if(loadCollectionAlert != nil) {
        //show loading indicator
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        indicator.center = CGPointMake(loadCollectionAlert.bounds.size.width/2, loadCollectionAlert.bounds.size.height-45);
        [indicator startAnimating];
        [loadCollectionAlert addSubview:indicator];
    }
    
    //checks network connection
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        NSLog(@"There IS NO internet connection");
        //shows alert if no network connection is found
        UIAlertView *connectionAlert = [[UIAlertView alloc] initWithTitle:@"No network connection" message:@"Please go to your device Settings and check your Wi-Fi or data connection." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        if(connectionAlert != nil)
        {
            [connectionAlert show];
        }
    }
    else
    {
        NSLog(@"There IS internet connection");
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
                                NSString *friendsListString = @"https://api.twitter.com/1.1/friends/list.json";
                            
                                //request URL
                                SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:friendsListString] parameters:nil];
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
                                            //put JSON results in dictionary
                                            friendsDictionary = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                          options:0
                                                                                            error:nil];
                                            if(friendsDictionary != nil)
                                            {
                                                //put user information in array
                                                followersArray = [friendsDictionary objectForKey:@"users"];
                                                NSLog(@"Followers Array:%@", followersArray);
                                                //allocate mutable array for storing data
                                                infoStorage = [[NSMutableArray alloc] init];
                                                //for each user in the followers array
                                                for (int i=0; i<[followersArray count]; i++)
                                                {
                                                    //store imageURL
                                                    NSString *imageURL = [[followersArray objectAtIndex:i] objectForKey:@"profile_image_url"];
                                                    NSLog(@"ImageURL: %@", imageURL);
                                                    //store imageData from imageURL
                                                    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
                                                    //store screen name
                                                    NSString *twitterName = [[followersArray objectAtIndex:i] objectForKey:@"screen_name"];
                                                    //store image in UIImage by using imageData
                                                    UIImage *image = [UIImage imageWithData:imageData];
                                                    //store screen name and avatar image in FollowerInfo object
                                                    info = [[FollowerInfo alloc] initWithInfo:twitterName images:image];
                                                    //add information to object
                                                    [infoStorage addObject:info];
                                                    
                                                    //stop loading alert
                                                    [loadCollectionAlert dismissWithClickedButtonIndex:0 animated:YES];
                                                }
                                                //causes table view to trigger a reload
                                                [friendsCollectionView reloadData];

                                                NSLog(@"Followers Array:%@", [followersArray description]);
                                                NSLog(@"Friends Dictionary:%@", friendsDictionary);
                                            }
                                        }
                                    }];
                                }
                            }
                        }
                    }
                    else if(!granted)
                    {                        
                        //alert user text field needs text and date
                        UIAlertView *grantedAlert = [[UIAlertView alloc] initWithTitle:@"Twitter Account" message:@"There is no Twitter account logged in. Please go to Settings and log into your Twitter account." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];

                            //show alert
                            [grantedAlert show];
                        NSLog(@"User did not grant access");
                        
                    }
                }];
            }
        }
    }

    //Create nib for CustomCollectionViewCell
    UINib *nib = [UINib nibWithNibName:@"CustomCollectionCellViewController" bundle:nil];
    if(nib != nil)
    {
        //register nib
        [friendsCollectionView registerNib:nib forCellWithReuseIdentifier:@"CustomCell"];
    }

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [infoStorage count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //create custom cell
    CustomCollectionCellView *cell = [friendsCollectionView dequeueReusableCellWithReuseIdentifier:@"CustomCell" forIndexPath:indexPath];
    if(cell != nil)
    {
        //store information from mutable array(infoStorage) in info (object from FollowerInfo)
        info = [infoStorage objectAtIndex:indexPath.row];
        //add avatar an screen name to cells
        [cell refreshCellData:info.avatarImages nameString:info.screenNames];
        return cell;

        NSLog(@"Success!!");
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //create detail view
    DetailViewController *detailView = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    if(detailView != nil)
    {
        //store information from mutable array(info Storage in info(object from FollowerInfo)
        info = [infoStorage objectAtIndex:indexPath.row];
        //store information from info object to the detail view info variable
        detailView.info = info;
        //present detail modal view
        [self presentViewController:detailView animated:true completion:nil];
    }
    
}

//optional
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
