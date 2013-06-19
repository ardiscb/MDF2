//
//  ImageCaptureViewController.h
//  CaptureApp
//
//  Created by Courtney Ardis on 6/18/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCaptureViewController : UIViewController
{
    IBOutlet UIImageView *originalImageView;
    IBOutlet UIImageView *editedImageView;
    UIImage *originalImage;
    UIImage *editedImage;
    NSDictionary *info;
}
@property (strong, nonatomic) NSDictionary *info;

-(IBAction)onClick:(id)sender;
@end
