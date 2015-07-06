//
//  MainViewController.h
//  TelevisionShow
//
//  Created by Arnel Perez on 7/2/15.
//  Copyright (c) 2015 Arnel Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVPullToRefresh.h"

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *arrayResult;
    NSMutableArray *dataSource;
    int arrayCount;
    int intActivePage;

}

@property (nonatomic, strong) IBOutlet UITableView *tblShows;
@property (nonatomic, strong) NSMutableArray *dataSource;


@end
