//
//  MovieCaptureViewController.m
//  CaptureApp
//
//  Created by Courtney Ardis on 6/19/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import "MovieCaptureViewController.h"
#import "ViewController.h"

#define CANCEL_BTN 0
#define SAVE_BTN 1

@interface MovieCaptureViewController ()

@end

@implementation MovieCaptureViewController
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
        //UIImageWriteToSavedPhotosAlbum(originalImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        NSURL *urlString = [info valueForKey:UIImagePickerControllerMediaURL];
        if(urlString != nil)
        {
            NSString *videoPath = [urlString path];
            NSLog(@"Video Path = %@", videoPath);
            
            UISaveVideoAtPathToSavedPhotosAlbum(videoPath, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
    }
}

//method for selector - signature
-(void)video:(UIImage *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    //if error is not nil, an error happened while saving
    if(error != nil)
    {
        NSLog(@"Error = %@", error);
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"An error has occured while saving your images." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        if(errorAlert != nil)
        {
            //show save alert
            [errorAlert show];
        }
    }
    //else error is nil, no errors while saving
    else
    {
        NSLog(@"Save successful!");
        //alert when save is succesful
        UIAlertView *saveAlert = [[UIAlertView alloc] initWithTitle:@"Saved Successful" message:@"Your movie has been saved successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        if(saveAlert != nil)
        {
            //show save alert
            [saveAlert show];
        }
        //dismiss view after save
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
