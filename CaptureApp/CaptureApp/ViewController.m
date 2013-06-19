//
//  ViewController.m
//  CaptureApp
//
//  Created by Courtney Ardis on 6/17/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import "ViewController.h"
#import "ImageCaptureViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize editedImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)onClick:(id)sender
{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    if(pickerController != nil)
    {
        //choose source
        //shows all albums
        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        //set up delegate
        pickerController.delegate = self;
        //set to true if you want to edit
        pickerController.allowsEditing = true;
        
        [self presentViewController:pickerController animated:true completion:nil];
    }
}

// user selected an image
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
