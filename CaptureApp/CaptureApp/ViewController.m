//
//  ViewController.m
//  CaptureApp
//
//  Created by Courtney Ardis on 6/17/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import "ViewController.h"
#import "ImageCaptureViewController.h"
#import "MovieCaptureViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>

#define CAPTURE_PHOTO 0
#define CAPTURE_VIDEO 1
#define PHOTO_ALBUM 2

@interface ViewController ()

@end

@implementation ViewController
@synthesize editedImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
   
    instructionsView.layer.cornerRadius = 10;
    [instructionsView.layer setShadowRadius:0.5f];
    instructionsView.layer.shadowColor = [UIColor blackColor].CGColor;
    instructionsView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    instructionsView.layer.shadowOpacity = 1.0f;
    instructionsView.layer.shadowRadius = 0.5f;
}
-(IBAction)onClick:(id)sender
{
    UIButton *button = sender;
    if (button.tag == CAPTURE_PHOTO)
    {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        if(pickerController != nil)
        {
            //choose source
            //shows camera capture
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            //set up delegate
            pickerController.delegate = self;
            //set to true - allows edit
            pickerController.allowsEditing = true;
            
            [self presentViewController:pickerController animated:true completion:nil];
        }
    }
    else if (button.tag == CAPTURE_VIDEO)
    {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        if(pickerController != nil)
        {
            //set source to camera
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            //set delegate
            pickerController.delegate = self;
            //set editing to true
            pickerController.allowsEditing = false;
            //set video quality
            pickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
            //set media types
            pickerController.mediaTypes = [NSArray arrayWithObjects:(NSString*)kUTTypeMovie, nil];
            
            [self presentViewController:pickerController animated:true completion:nil];
        }
    }
    else if (button.tag == PHOTO_ALBUM)
    {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        if(pickerController != nil)
        {
            //choose source
            //shows photo album
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //set up delegate
            pickerController.delegate = self;
            //set false - no editting
            pickerController.allowsEditing = false;
            
            [self presentViewController:pickerController animated:true completion:nil];
        }
    }
}

// user selected an image
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //stores media type in string
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //if media type is image
    if([mediaType isEqualToString:@"public.image"])
    {
        ImageCaptureViewController *captureView = [[ImageCaptureViewController alloc] initWithNibName:@"ImageCaptureViewController" bundle:nil];
        if(captureView != nil)
        {
            //log information from dictionary (info)
            NSLog(@"Info = %@", [info description]);
            //set info from captureView to info objects in this method
            captureView.info = info;
            //open picker
            [picker presentViewController:captureView animated:true completion:nil];
        }
    }
    //if media type is movie
    else if([mediaType isEqualToString:@"public.movie"])
    {
        MovieCaptureViewController *movieView = [[MovieCaptureViewController alloc] initWithNibName:@"MovieCaptureViewController" bundle:nil];
        if(movieView != nil)
        {
            NSLog(@"Movie Info = %@", info);
            movieView.info = info;
            [picker presentViewController:movieView animated:true completion:nil];
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
