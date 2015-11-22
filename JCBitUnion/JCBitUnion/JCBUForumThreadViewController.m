
//
//  JCBUForumThreadViewController.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/14/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUForumThreadViewController.h"
#import "JCBUUser.h"
#import "JCBUForumThreadView.h"
#import "JCBUForumThreadInfo.h"
#import "JCBUPostDetailedViewController.h"
#import "JCBUForumThreadListCell.h"
#import "JCBUPostNavigationView.h"

@interface JCBUForumThreadViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation JCBUForumThreadViewController
{
  JCBUUser *_userInfo;
  NSString *_forumId;
  NSString *_forumName;
  JCBUForumThreadView *_forumThreadView;
  
  NSMutableArray *_forumThreadInfos;
  UIRefreshControl *_ptrControl;
  NSInteger _currentPage;
  NSInteger _postNumber;
}

- (instancetype)initWithUserInfo:(JCBUUser *)userInfo forumId:(NSString *)forumId forumName:(NSString *)forumName
{
  if (self = [super init]) {
    _forumThreadView = [[JCBUForumThreadView alloc] init];
    _forumThreadView.tableView.dataSource = self;
    _forumThreadView.tableView.delegate = self;
    
    _userInfo = userInfo;
    _forumId = forumId;
    _forumName = forumName;
    self.navigationItem.title = forumName;
    _forumThreadInfos = [NSMutableArray new];
    
    self.hidesBottomBarWhenPushed = YES;
    
    _ptrControl = [[UIRefreshControl alloc] init];
    [_ptrControl addTarget:self
                    action:@selector(_pullToRefreshFirstPage)
          forControlEvents:UIControlEventValueChanged];
    [_ptrControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@"Release to refresh"]];
    
    _currentPage = 0;
    
    [self _fetchPostNumber];
  }
  
  return self;
}

- (void)loadView
{
  self.view = _forumThreadView;
}

- (void)viewDidLoad
{
  UITableViewController *tableVC = [[UITableViewController alloc] init];
  tableVC.tableView = _forumThreadView.tableView;
  
  tableVC.refreshControl = _ptrControl;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _forumThreadInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  JCBUForumThreadListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"forumThreadCell"];
  if (!cell) {
    cell = [[JCBUForumThreadListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"forumThreadCell"];
  }
  
  JCBUForumThreadInfo *threadInfo = _forumThreadInfos[indexPath.row];
  cell.subjectLabel.text = [[threadInfo.subject stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
  if (threadInfo.dateLine) {
    NSTimeInterval _interval = [threadInfo.dateLine doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    cell.dateLabel.text = [formatter stringFromDate:date];
  }
  
  
  cell.replyNumberLabel.text = threadInfo.replies;
  cell.authorLabel.text = [[threadInfo.author stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  JCBUForumThreadInfo *threadInfo = _forumThreadInfos[indexPath.row];
  JCBUPostDetailedViewController *postdetailedVC = [[JCBUPostDetailedViewController alloc] initWithUserInfo:_userInfo
                                                                                                     postId:threadInfo.tid
                                                                                                postSubject:[[threadInfo.subject stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                                                                                               forumSubject:_forumName];
  [self.navigationController pushViewController:postdetailedVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 75;
}

#pragma mark - helper methods;

- (void)_fetchPostNumber
{
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^() {
    NSError *error;
    NSMutableDictionary *fetchPostDict = [NSMutableDictionary new];
    [fetchPostDict setObject:_userInfo.userName forKey:@"username"];
    [fetchPostDict setObject:_userInfo.userSession forKey:@"session"];
    [fetchPostDict setObject:_forumId forKey:@"fid"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:fetchPostDict
                                                       options:0
                                                         error:&error];
    
    NSURL *bitUnionLogInUrl = [NSURL URLWithString:@"http://out.bitunion.org/open_api/bu_fid_tid.php"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = bitUnionLogInUrl;
    [request setHTTPMethod:@"POST" ];
    [request setHTTPBody:jsonData];
    
    NSHTTPURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"Response status code is: %li", response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      NSString *responseData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
      NSLog(@"Response ==> %@", responseData);
      
      NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
      if ([responseDict[@"result"] isEqualToString:@"success"]) {
        _postNumber = [responseDict[@"fid_sum"] intValue] / 20 + 1;
        
        [self _fetchPostThreadsFrom:0 to:20 increasePageNumBy:1];
      }
    } else {
      NSLog(@"Connection failed");
    }
    
  });
}

// [TODO] fetch subforum info. Then figure out why forum page number is correct but the posts are not displayed
- (void)_fetchPostThreadsFrom:(NSInteger)fromIndex to:(NSInteger)toIndex increasePageNumBy:(NSInteger)num
{
  [_forumThreadView.loadingIndicator startAnimating];
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^() {
    NSError *error;
    NSMutableDictionary *postThreadsDict = [NSMutableDictionary new];
    [postThreadsDict setObject:@"thread" forKey:@"action"];
    [postThreadsDict setObject:_userInfo.userName forKey:@"username"];
    [postThreadsDict setObject:_userInfo.userSession forKey:@"session"];
    [postThreadsDict setObject:_forumId forKey:@"fid"];
    [postThreadsDict setObject:[NSString stringWithFormat:@"%li", fromIndex] forKey:@"from"];
    [postThreadsDict setObject:[NSString stringWithFormat:@"%li", toIndex] forKey:@"to"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postThreadsDict
                                                       options:0
                                                         error:&error];
    
    NSURL *bitUnionLogInUrl = [NSURL URLWithString:@"http://out.bitunion.org/open_api/bu_thread.php"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = bitUnionLogInUrl;
    [request setHTTPMethod:@"POST" ];
    [request setHTTPBody:jsonData];
    
    NSHTTPURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"Response status code is: %li", response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      NSString *responseData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
      NSLog(@"Response ==> %@", responseData);
      
      NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
      if ([responseDict[@"result"] isEqualToString:@"success"]) {
        NSLog(@"Fetch post threads success");
        
        _currentPage += num;
        if (_forumThreadInfos.count > 0) {
          [_forumThreadInfos removeAllObjects];
        }
        
        for (NSDictionary *threadInfo in responseDict[@"threadlist"]){
          JCBUForumThreadInfo *forumThreadInfo = [[JCBUForumThreadInfo alloc] initWithAuthor:threadInfo[@"author"]
                                                                                    authorId:threadInfo[@"authorid"]
                                                                                    dateLine:threadInfo[@"dateline"]
                                                                                    lastPost:threadInfo[@"lastpost"]
                                                                                  lastPoster:threadInfo[@"lastposter"]
                                                                                     replies:threadInfo[@"replies"]
                                                                                     subject:threadInfo[@"subject"]
                                                                                         tid:threadInfo[@"tid"]
                                                                                       views:threadInfo[@"views"]];
          
          [_forumThreadInfos addObject:forumThreadInfo];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^(){
          [_forumThreadView.loadingIndicator stopAnimating];
          _forumThreadView.postNavigationView.pageLabel.text = [NSString stringWithFormat:@"%li / %li", _currentPage, _postNumber];
          _forumThreadView.postNavigationView.leftButton.enabled = _currentPage > 1 ? YES : NO;
          _forumThreadView.postNavigationView.leftMostButton.enabled = _currentPage > 1 ? YES : NO;
          _forumThreadView.postNavigationView.rightButton.enabled = (_currentPage < _postNumber) ? YES : NO;
          _forumThreadView.postNavigationView.rightMostButton.enabled = (_currentPage < _postNumber) ? YES : NO;
          [_forumThreadView.tableView reloadData];
        });
      } else {
        NSLog(@"Fetch post threads failed: %@", responseDict[@"msg"]);
        dispatch_async(dispatch_get_main_queue(), ^(){
          [_forumThreadView.loadingIndicator stopAnimating];
        });
      }
    } else {
      NSLog(@"Server failed when fetching user info");
      dispatch_async(dispatch_get_main_queue(), ^(){
        [_forumThreadView.loadingIndicator stopAnimating];
      });
    }
  });
}

- (void)_pullToRefreshFirstPage
{
  [self _fetchPostThreadsFrom:(_currentPage - 1) * 20 to:_currentPage * 20 increasePageNumBy:0];
  [_ptrControl endRefreshing];
}

#pragma mark - Post page navigation methods

- (void)didTapPreviousPageButton
{
  if (_currentPage - 2 >= 0) {
    [self _fetchPostThreadsFrom:(_currentPage - 2) * 20 to:(_currentPage - 1) * 20 increasePageNumBy:-1];
  }
}

- (void)didTapNextPageButton
{
  [self _fetchPostThreadsFrom:_currentPage * 20 to:(_currentPage + 1) * 20 increasePageNumBy:1];
}

- (void)didTapLeftMostPageButton
{
  [self _fetchPostThreadsFrom:0 to:20 increasePageNumBy:-(_currentPage - 1)];
}

- (void)didTapRightMostPageButton
{
  [self _fetchPostThreadsFrom:(_postNumber - 1) * 20 to:_postNumber * 20 increasePageNumBy:(_postNumber - _currentPage)];
}

@end
