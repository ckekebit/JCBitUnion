//
//  JCBUForumListViewController.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/14/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUForumListViewController.h"
#import "JCBUForumInfo.h"
#import "JCBUuser.h"
#import "JCBUForumThreadViewController.h"

@interface JCBUForumListViewController ()

@end

// [TODO] subforums
@implementation JCBUForumListViewController
{
  JCBUUser *_userInfo;
}

- (instancetype)initWithUserInfo:(JCBUUser *)userInfo forumList:(NSArray *)forumList forumGroupSubject:(NSString *)forumGroupSubject
{
  if (self = [super init]) {
    _forumList = forumList;
    _userInfo = userInfo;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.navigationItem.title = forumGroupSubject;
  }
  
  return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
  return _forumList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"forumListCell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"forumListCell"];
  }
  
  JCBUForumInfo *forumInfo = (JCBUForumInfo *)_forumList[indexPath.row];
  cell.textLabel.text = [[forumInfo.name stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  if (forumInfo.subForums.count > 0) {
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
  } else {
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  JCBUForumInfo *forumInfo = ((JCBUForumInfo *)_forumList[indexPath.row]);
  JCBUForumThreadViewController *forumThreadVC = [[JCBUForumThreadViewController alloc] initWithUserInfo:_userInfo forumId:forumInfo.fid forumName:[[((JCBUForumInfo *)_forumList[indexPath.row]).name stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  
  [self.navigationController pushViewController:forumThreadVC animated:YES];
}

@end
