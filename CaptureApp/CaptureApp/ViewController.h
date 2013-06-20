//
//  ViewController.h
//  CaptureApp
//
//  Created by Courtney Ardis on 6/17/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    IBOutlet UIButton *imageCaptureBtn;
    IBOutlet UIButton *movieCaptureBtn;
    IBOutlet UIButton *photoAlbumBtn;
    IBOutlet UITextView *instructionsView;
}

@property (strong, nonatomic)UIImage *editedImage;

-(IBAction)onClick:(id)sender;
@end
