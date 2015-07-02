//
//  ShowInfoViewController.h
//  TelevisionShow
//
//  Created by Arnel Perez on 7/2/15.
//  Copyright (c) 2015 Arnel Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowInfoViewController : UIViewController
{
    NSDictionary *dictShowInfo;
}

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgRatings;
@property (weak, nonatomic) IBOutlet UITextView *txtSummary;
@property (nonatomic, strong) NSDictionary *dictShowInfo;

@end
