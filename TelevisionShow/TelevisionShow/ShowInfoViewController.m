//
//  ShowInfoViewController.m
//  TelevisionShow
//
//  Created by Arnel Perez on 7/2/15.
//  Copyright (c) 2015 Arnel Perez. All rights reserved.
//

#import "ShowInfoViewController.h"

@interface ShowInfoViewController ()

@end

@implementation ShowInfoViewController
@synthesize lblTime,lblName,imgRatings,dictShowInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    NSString *strName = [NSString stringWithFormat:@"%@",[dictShowInfo objectForKey:@"name"]];
    NSString *strStartTime = [NSString stringWithFormat:@"%@",[dictShowInfo objectForKey:@"start_time"]];
    NSString *strEndTime = [NSString stringWithFormat:@"%@",[dictShowInfo objectForKey:@"end_time"]];
    NSString *strRating = [NSString stringWithFormat:@"%@",[dictShowInfo objectForKey:@"rating"]];
    NSString *strRatingImage = [NSString stringWithFormat:@"%@.png",strRating];
    //NSString *strChannel = [NSString stringWithFormat:@"%@",[dictShowInfo objectForKey:@"channel"]];
    //NSString *strChannelImage = [NSString stringWithFormat:@"%@.png",strChannel];
    
    self.title = strName;
    
    lblName.text = strName;
    lblTime.text = [NSString stringWithFormat:@"%@-%@",strStartTime,strEndTime];
    imgRatings.image =[UIImage imageNamed:strRatingImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
