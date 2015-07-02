//
//  MainViewController.m
//  TelevisionShow
//
//  Created by Arnel Perez on 7/2/15.
//  Copyright (c) 2015 Arnel Perez. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewItemCell.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ShowInfoViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.title =@"My Movies";
    
    [self getTVShows];
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tblShows.bounds.size.height, self.view.frame.size.width, self.tblShows.bounds.size.height)];
        view.delegate = self;
        [self.tblShows addSubview:view];
        _refreshHeaderView = view;
    }
}

-(void) getTVShows{
    NSString *strURL = @"http://www.whatsbeef.net/wabz/guide.php?start=1";
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString: strURL]];
    [request setRequestMethod:@"GET"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request startSynchronous];
    
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    NSLog(@"error: %@",error);
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"responseData UserInfo: %@",responseData);
        
        NSMutableDictionary *dictData = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error:nil];
        
        arrayResult = [[NSMutableArray alloc]init];
        arrayResult =[dictData objectForKey:@"results"];
        NSLog(@"dictData: %@", [dictData objectForKey:@"count"]);
    }
    [self.tblShows reloadData];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [arrayResult count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *jsonData = [arrayResult objectAtIndex:indexPath.section];
    static NSString *simpleTableIdentifier = @"Cell";
    HomeViewItemCell *cell = (HomeViewItemCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HomeViewItemCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSString *strName = [NSString stringWithFormat:@"%@",[jsonData objectForKey:@"name"]];
    NSString *strStartTime = [NSString stringWithFormat:@"%@",[jsonData objectForKey:@"start_time"]];
    NSString *strEndTime = [NSString stringWithFormat:@"%@",[jsonData objectForKey:@"end_time"]];
    NSString *strChannel = [NSString stringWithFormat:@"%@",[jsonData objectForKey:@"channel"]];
    NSString *strRating = [NSString stringWithFormat:@"%@",[jsonData objectForKey:@"rating"]];

    NSString *strRatingImage = [NSString stringWithFormat:@"%@.png",strRating];
    cell.imgRatings.image = [UIImage imageNamed:strRatingImage];

    NSString *strChannelImage = [NSString stringWithFormat:@"%@.png",strChannel];
    cell.imgLogo.image = [UIImage imageNamed:strChannelImage];

    cell.lblTitle.text = strName;
    cell.lblTime.text = [NSString stringWithFormat:@"%@-%@",strStartTime,strEndTime];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *jsonData = [arrayResult objectAtIndex:indexPath.section];
    ShowInfoViewController *showInfoVC = [[ShowInfoViewController alloc] initWithNibName:@"ShowInfoViewController" bundle:[NSBundle mainBundle]];
    showInfoVC.dictShowInfo = jsonData;
    [self.navigationController pushViewController:showInfoVC animated:YES];
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    //  should be calling your tableviews data source model to reload
    [self getTVShows];
    _reloading = YES;
}

- (void)doneLoadingTableViewData{
    //  model should call this when its done loading
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tblShows];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date]; // should return date data source was last changed
}

#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    _refreshHeaderView=nil;
}

- (void)dealloc {
    _refreshHeaderView = nil;
}

@end
