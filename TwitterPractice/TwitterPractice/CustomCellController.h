//
//  CustomCellController.h
//  TwitterPractice
//
//  Created by Courtney Ardis on 6/4/13.
//  Copyright (c) 2013 Courtney Ardis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellController : UITableViewCell
{
    IBOutlet UIImageView *profileImage;
    IBOutlet UILabel *tweetLabel;
    IBOutlet UILabel *dateLabel;
}

@property (nonatomic, strong)UIImageView *profileImage;
@property (nonatomic, strong)UILabel *tweetLabel;
@property (nonatomic, strong)UILabel *dateLabel;
@end
