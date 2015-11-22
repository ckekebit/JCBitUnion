//
//  JCBUFirstPageViewController.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/21/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import "JCBUFirstPageViewController.h"
#import "JCBUUser.h"
#import "JCBUFirstPageView.h"
#import "JCBUFirstPagePostCell.h"
#import "JCBUUserInfoViewController.h"
#import "JCBUPostDetailedInfo.h"
#import "JCBUPostDetailedViewController.h"
#import "JCBUForumThreadViewController.h"

@interface JCBUFirstPageViewController() <JCBUFirstPagePostCellDelegate>

@end

@implementation JCBUFirstPageViewController
{
  JCBUUser *_userInfo;
  NSArray *_mostRecentPosts;
  JCBUFirstPageView *_firstPageView;
  UIRefreshControl *_ptrControl;
}

- (instancetype)initWithUserInfo:(JCBUUser *)userInfo
{
  if (self = [super init]) {
    self.tabBarItem.title = @"首页";
    self.tabBarItem.image = [UIImage imageNamed:@"firstpage.png"];
    
    _userInfo = userInfo;
    
    _firstPageView = [[JCBUFirstPageView alloc] init];
    _firstPageView.tableView.delegate = self;
    _firstPageView.tableView.dataSource = self;
    
    _ptrControl = [[UIRefreshControl alloc] init];
    [_ptrControl addTarget:self
                    action:@selector(_pullToRefreshFirstPage)
          forControlEvents:UIControlEventValueChanged];
    [_ptrControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@"Release to refresh"]];
    
    [self _fetchMostRecentPosts];
  }
  
  return self;
}

- (void)loadView
{
  self.view = _firstPageView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.edgesForExtendedLayout = UIRectEdgeNone;
  
  // Initialize the refresh control.
  // [TODO] feature request
  // Use UIScrollView to implement a better PTR
  // 1. different distance triggers differet behavior
  // 2. pull up refresh
  // 3. customized refresh view: last update time, different arrows, etc:
  //    http://blog.csdn.net/x6587305x/article/details/42640291
  // Refer to mitbbs App for what I mean here
  UITableViewController *tableVC = [[UITableViewController alloc] init];
  tableVC.tableView = _firstPageView.tableView;
  
  tableVC.refreshControl = _ptrControl;

}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 75;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _mostRecentPosts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  JCBUFirstPagePostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstPagePostCell"];
  if (!cell) {
    cell = [[JCBUFirstPagePostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"firstPagePostCell"];
  }
  
  cell.cellIndex = indexPath.row;
  cell.delegate = self;
  cell.subjectLabel.text = [[_mostRecentPosts[indexPath.row][@"pname"] stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  cell.forumLabel.text = [[_mostRecentPosts[indexPath.row][@"fname"] stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  cell.authorLabel.text = [[_mostRecentPosts[indexPath.row][@"author"] stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
  return cell;
}

#pragma mark - helper methods

// According to API description, can fetch at most 20 posts
- (void)_fetchMostRecentPosts
{
  [_firstPageView.loadingIndicator startAnimating];
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^() {
    NSError *error;
    NSMutableDictionary *recentPostsInfoDict = [NSMutableDictionary new];
    [recentPostsInfoDict setObject:_userInfo.userName forKey:@"username"];
    [recentPostsInfoDict setObject:_userInfo.userSession forKey:@"session"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:recentPostsInfoDict
                                                       options:0
                                                         error:&error];
    
    NSURL *bitUnionLogInUrl = [NSURL URLWithString:@"http://out.bitunion.org/open_api/bu_home.php"];
    
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
        NSLog(@"Fetch recent posts success");
        
        _mostRecentPosts = responseDict[@"newlist"];
        dispatch_async(dispatch_get_main_queue(), ^(){
          [_firstPageView.loadingIndicator stopAnimating];
          [_firstPageView.tableView reloadData];
        });
      } else {
        NSLog(@"Fetch recent posts failed: %@", responseDict[@"msg"]);
      }
    } else {
      NSLog(@"Server failed when fetching user info");
    }
  });
}

- (void)_pullToRefreshFirstPage
{
  [self _fetchMostRecentPosts];
  
  [_ptrControl endRefreshing];
}

#pragma mark - JCBUFirstPagePostCellDelegate

- (void)didTapAuthor:(NSString *)postAuthor
{
  JCBUUserInfoViewController *userInfoViewController = [[JCBUUserInfoViewController alloc] initWithUserInfo:_userInfo postAuthor:postAuthor];
  [self.navigationController pushViewController:userInfoViewController animated:YES];
}

- (void)didTapSubject:(NSUInteger)cellIndex
{
  JCBUPostDetailedViewController *postdetailedVC = [[JCBUPostDetailedViewController alloc] initWithUserInfo:_userInfo postId:_mostRecentPosts[cellIndex][@"tid"] postSubject:_mostRecentPosts[cellIndex][@"pname"] forumSubject:_mostRecentPosts[cellIndex][@"fname"]];
  [self.navigationController pushViewController:postdetailedVC animated:YES];
}

- (void)didTapForum:(NSUInteger)cellIndex
{
  NSString *forumName = [[_mostRecentPosts[cellIndex][@"fname"] stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  JCBUForumThreadViewController *forumThreadVC = [[JCBUForumThreadViewController alloc] initWithUserInfo:_userInfo forumId:_mostRecentPosts[cellIndex][@"fid"] forumName:forumName];
  
  [self.navigationController pushViewController:forumThreadVC animated:YES];
}

@end
