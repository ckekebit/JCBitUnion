//
//  JCBUForumGroupListViewController.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/14/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import "JCBUForumGroupListViewController.h"
#import "JCBUUser.h"
#import "JCBUForumGroupInfo.h"
#import "JCBUForumInfo.h"
#import "JCBUForumListViewController.h"

@interface JCBUForumGroupListViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation JCBUForumGroupListViewController
{
  JCBUUser *_userInfo;
  NSMutableArray *_forumGroupList;
}

- (instancetype)initWithUserInfo:(JCBUUser *)userInfo
{
  if (self = [super init]) {
    self.tabBarItem.title = @"版面";
    self.tabBarItem.image = [UIImage imageNamed:@"forumlist.png"];
    
    _userInfo = userInfo;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _forumGroupList = [NSMutableArray new];
    
    [self _fetchForumList];
  }
  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)_fetchForumList
{
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^() {
    NSError *error;
    NSMutableDictionary *forumListDict = [NSMutableDictionary new];
    [forumListDict setObject:@"forum" forKey:@"action"];
    [forumListDict setObject:_userInfo.userName forKey:@"username"];
    [forumListDict setObject:_userInfo.userSession forKey:@"session"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:forumListDict
                                                       options:0
                                                         error:&error];

    NSURL *bitUnionLogInUrl = [NSURL URLWithString:@"http://out.bitunion.org/open_api/bu_forum.php"];

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
        NSLog(@"Fetching forum list success");

        for (NSString *key in [responseDict[@"forumslist"] allKeys]) {
          // The forum group with en empty group is for FTP owners I think
          if (key.length > 0) {
            NSString *forumGroupId = responseDict[@"forumslist"][key][@"main"][@"fid"];
            NSString *forumGroupName = [[responseDict[@"forumslist"][key][@"main"][@"name"] stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *forumGroupType = responseDict[@"forumslist"][key][@"main"][@"type"];
            
            NSMutableArray *forumList = [NSMutableArray new];
            
            for (NSString *forumKey in [responseDict[@"forumslist"][key] allKeys]) {
              if (forumKey.length > 0 && ![forumKey isEqualToString:@"main"]) {
                // Parse out the subForums first
                NSArray *subforumDict = responseDict[@"forumslist"][key][forumKey][@"sub"];
                NSMutableArray *subForums = [NSMutableArray new];
                for (NSDictionary *subForumInfo in subforumDict) {
                  JCBUForumInfo *forumInfo = [[JCBUForumInfo alloc] initWithDescription:subForumInfo[@"description"]
                                                                                    fid:subForumInfo[@"fid"]
                                                                                    fup:subForumInfo[@"fup"]
                                                                                   icon:subForumInfo[@"icon"]
                                                                              moderator:subForumInfo[@"moderator"]
                                                                                   name:subForumInfo[@"name"]
                                                                                onlines:subForumInfo[@"onlines"]
                                                                                  posts:subForumInfo[@"posts"]
                                                                                threads:subForumInfo[@"threads"]
                                                                                   type:subForumInfo[@"type"]
                                                                              subForums:nil];
                  [subForums addObject:forumInfo];
                }
                
                NSDictionary *forumDict = responseDict[@"forumslist"][key][forumKey][@"main"][0];
                JCBUForumInfo *forumInfo = [[JCBUForumInfo alloc] initWithDescription:forumDict[@"description"]
                                                                                  fid:forumDict[@"fid"]
                                                                                  fup:forumDict[@"fup"]
                                                                                 icon:forumDict[@"icon"]
                                                                            moderator:forumDict[@"moderator"]
                                                                                 name:forumDict[@"name"]
                                                                              onlines:forumDict[@"onlines"]
                                                                                posts:forumDict[@"posts"]
                                                                              threads:forumDict[@"threads"]
                                                                                 type:forumDict[@"type"]
                                                                            subForums:subForums];
                [forumList addObject:forumInfo];
              }
            }
            
            JCBUForumGroupInfo *forumGroupInfo = [[JCBUForumGroupInfo alloc] initWithForumGroupId:forumGroupId
                                                                                   forumGroupName:forumGroupName
                                                                                   forumGroupType:forumGroupType
                                                                                        forumList:forumList];

            
            [_forumGroupList addObject:forumGroupInfo];
          }
        }
      } else {
        NSLog(@"Fetching forum list failed: %@", responseDict[@"msg"]);
      }
    } else {
      NSLog(@"Connection failed");
    }
  });
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _forumGroupList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"forumGroupListCell"];
  //if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"forumGroupListCell"];
  //}
  
  cell.textLabel.text = ((JCBUForumGroupInfo *)_forumGroupList[indexPath.row]).forumGroupName;
  cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  JCBUForumListViewController *forumListViewVC = [[JCBUForumListViewController alloc] initWithUserInfo:_userInfo
                                                                                             forumList:((JCBUForumGroupInfo *)_forumGroupList[indexPath.row]).forumList
                                                                                     forumGroupSubject:((JCBUForumGroupInfo *)_forumGroupList[indexPath.row]).forumGroupName];
  [self.navigationController pushViewController:forumListViewVC animated:YES];
}

@end
