//
//  DetailViewController.m
//  TwitterFriendsApp
//
//  Created by Courtney Ardis on 6/13/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import "DetailViewController.h"
#import "FollowerInfo.h"


@interface DetailViewController ()
{
    
}
@end

@implementation DetailViewController
@synthesize info, avatarImageView, screenNameLabel;

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
    //set image(avatar) for detail view
    avatarImageView.image = info.avatarImages;
    //set text(screen name) for detail view
    screenNameLabel.text = info.screenNames;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
