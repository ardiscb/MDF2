//
//  MovieCaptureViewController.h
//  CaptureApp
//
//  Created by Courtney Ardis on 6/19/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCaptureViewController : UIViewController
{
    NSDictionary *info;
}

@property (nonatomic, strong) NSDictionary *info;

-(IBAction)onClick:(id)sender;
@end
