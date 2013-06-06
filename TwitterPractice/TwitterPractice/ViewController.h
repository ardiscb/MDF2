//
//  ViewController.h
//  TwitterPractice
//
//  Created by Courtney Ardis on 6/4/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import <UIKit/UIKit.h>

//code block definition
//typedef void (^DetailsHandler)(NSString*);

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    //DetailsHandler handler;
    
    NSArray *twitterFeed;
    NSDictionary *tweetDictionary;
    NSDictionary *twitterData;
    NSString *tweetText;
    NSDate *tweetDate;
    NSDateFormatter *dateFormatter;
    NSString *formattedDate;
    
    IBOutlet UITableView *twitterTableView;
    //NSDateFormatter *dateFormatter;
    
    UIAlertView *tableLoadAlert;
    UIAlertView *refreshAlert;
}
-(IBAction)onClick:(id)sender;
//@property (nonatomic, strong)DetailsHandler handler;
//@property (nonatomic, strong)NSString *tweetText;
@end
