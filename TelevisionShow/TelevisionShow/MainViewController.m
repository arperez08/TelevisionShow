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
#import "SVPullToRefresh.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize dataSource, tblShows;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    intActivePage = 0;
    
    // Do any additional setup after loading the view from its nib.
    self.title =@"My Movies";
    
    [self getTVShows:intActivePage];
    
     //__weak MainViewController *weakSelf = self;
    
    // setup infinite scrolling
    [self.tblShows addInfiniteScrollingWithActionHandler:^{
        [self insertRowAtBottom:intActivePage];
    }];
}

- (void)insertRowAtBottom: (int) intPage {
    NSString *strURL = [NSString stringWithFormat:@"http://www.whatsbeef.net/wabz/guide.php?start=%d",intPage];
    NSLog(@"%@",strURL);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString: strURL]];
    [request setRequestMethod:@"GET"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"User-Agent" value:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0) Gecko/20100101 Firefox/38.0"];
    [request startSynchronous];
    
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    //NSLog(@"error: %@",error);
    if (!error) {
        //NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        //NSLog(@"responseData UserInfo: %@",responseData);
        
        NSMutableDictionary *dictData = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray * arrayDataResult = [[NSMutableArray alloc]init];
        arrayDataResult = [dictData objectForKey:@"results"];
        for (int i=0; i < [arrayDataResult count]; i++) {
            [arrayResult addObject:[arrayDataResult objectAtIndex:i]];
        }
        arrayCount = [[dictData objectForKey:@"count"]intValue];
    }
    //NSLog(@"arrayResult: %@",arrayResult);
    [tblShows.infiniteScrollingView stopAnimating];
    [self.tblShows reloadData];
    
    intActivePage = intActivePage + 1;
}

-(void) getTVShows: (int) intPage{
    NSString *strURL = [NSString stringWithFormat:@"http://www.whatsbeef.net/wabz/guide.php?start=%d",intPage];
    NSLog(@"%@",strURL);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString: strURL]];
    [request setRequestMethod:@"GET"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"User-Agent" value:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0) Gecko/20100101 Firefox/38.0"];
    [request startSynchronous];
    
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    //NSLog(@"error: %@",error);
    if (!error) {
        //NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        //NSLog(@"responseData UserInfo: %@",responseData);
        
        NSMutableDictionary *dictData = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray * arrayDataResult = [[NSMutableArray alloc]init];
        arrayDataResult = [dictData objectForKey:@"results"];
        
        arrayResult = [[NSMutableArray alloc]init];
        //arrayResult =[dictData objectForKey:@"results"];
        for (int i=0; i < [arrayDataResult count]; i++) {
            [arrayResult addObject:[arrayDataResult objectAtIndex:i]];
        }
        //NSLog(@"dictData: %@", [dictData objectForKey:@"count"]);
        arrayCount = [[dictData objectForKey:@"count"]intValue];
    }
    NSLog(@"arrayResult: %@",arrayResult);
    [self.tblShows reloadData];
    
    intActivePage = intActivePage + 1;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

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
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
