//
//  HomeViewItemCell.m
//  TelevisionShow
//
//  Created by Arnel Perez on 7/2/15.
//  Copyright (c) 2015 Arnel Perez. All rights reserved.
//

#import "HomeViewItemCell.h"

@implementation HomeViewItemCell
@synthesize lblTime,lblTitle,imgLogo,imgRatings;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
