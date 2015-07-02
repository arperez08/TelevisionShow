//
//  HomeViewItemCell.h
//  TelevisionShow
//
//  Created by Arnel Perez on 7/2/15.
//  Copyright (c) 2015 Arnel Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewItemCell : UITableViewCell{
    
}

@property (nonatomic, strong) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imgLogo;
@property (strong, nonatomic) IBOutlet UIImageView *imgRatings;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;



@end
