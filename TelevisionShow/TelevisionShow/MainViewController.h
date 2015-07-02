//
//  MainViewController.h
//  TelevisionShow
//
//  Created by Arnel Perez on 7/2/15.
//  Copyright (c) 2015 Arnel Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    NSMutableArray *arrayResult;
    int intActivePage;
    IBOutlet UISegmentedControl *segmentedControl;
}

@property (nonatomic, strong) IBOutlet UITableView *tblShows;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)btnPage0:(id)sender;
- (IBAction)btnPage1:(id)sender;
- (IBAction)btnPage2:(id)sender;
- (IBAction)segmentPage:(id)sender;

@end
