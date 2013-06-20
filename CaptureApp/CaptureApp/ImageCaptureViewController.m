//
//  ImageCaptureViewController.m
//  CaptureApp
//
//  Created by Courtney Ardis on 6/18/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import "ImageCaptureViewController.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#define CANCEL_BTN 0
#define SAVE_BTN 1


@interface ImageCaptureViewController ()

@end

@implementation ImageCaptureViewController
@synthesize info;

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
    
    NSLog(@"ImageCaptureView Info: %@", info);
    originalImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if(originalImage != nil)
    {
        //put original image in UIImageView on ImageCapture view
        originalImageView.image = originalImage;
        
    }
    editedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    if (editedImage != nil)
    {
        //put edited image in UIImageView on ImageCapture view
        editedImageView.image = editedImage;
    }

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)onClick:(id)sender
{
    UIButton *button = sender;
    if(button.tag == CANCEL_BTN)
    {
        //dismiss view on cancel
        [self dismissViewControllerAnimated:true completion:nil];
    }
    if(button.tag == SAVE_BTN)
    {
        //save original image
        UIImageWriteToSavedPhotosAlbum(originalImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

        //save edited image
        UIImageWriteToSavedPhotosAlbum(editedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
        //alert when save is succesful
        UIAlertView *saveAlert = [[UIAlertView alloc] initWithTitle:@"Saved Successful" message:@"Your images have been saved successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        if(saveAlert != nil)
        {
            //show save alert
            [saveAlert show];
        }
    }
}

//method for selector - signature
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    //if error is not nil, an error happened while saving
    if(error != nil)
    {
        NSLog(@"Error = %@", error);
        //alert when error occurs
        UIAlertView *saveAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"An error has occured while saving your images." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        if(saveAlert != nil)
        {
            //show save alert
            [saveAlert show];
        }
    }
    //else error is nil, no errors while saving
    else
    {
        NSLog(@"Save successful!");
        //present main view after save
        ViewController *mainView = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        [self presentViewController:mainView animated:true completion:nil];
    }
}
// user selected cancel button
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:true completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
