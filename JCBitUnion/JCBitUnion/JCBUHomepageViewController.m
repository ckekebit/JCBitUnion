//
//  JCBUHomepageViewController.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/20/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import "JCBUHomepageViewController.h"
#import "JCBUUser.h"
#import "JCBUUserInfoViewController.h"
#import "JCBUDetailedUserInfo.h"
#import "JCBULogInViewController.h"

@interface JCBUHomepageViewController ()

@end

@implementation JCBUHomepageViewController
{
  JCBUUser *_userInfo;
}

- (instancetype)initWithLoggedInUser:(JCBUUser *)userInfo
{
  if (self = [super init]) {
    self.tabBarItem.title = @"家页";
    self.tabBarItem.image = [UIImage imageNamed:@"homepage.png"];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _userInfo = userInfo;
  }
  
  return self;
}

- (void)viewDidLoad
{
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homePageCell"];
  }
  
  if (indexPath.row == 0) {
    cell.imageView.image = [UIImage imageNamed:@"male_outline.jpg"];
    cell.textLabel.text = @"我的资料";
  } else {
    cell.imageView.image = [UIImage imageNamed:@"logout.png"];
    cell.textLabel.text = @"注销";
  }
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == 0) {
    // Open detailed user info page
    JCBUUserInfoViewController *userInfoViewController = [[JCBUUserInfoViewController alloc] initWithUserInfo:_userInfo postAuthor:nil];
    [self.navigationController pushViewController:userInfoViewController animated:YES];
  } else if (indexPath.row == 1) {
    // Log out
    [self _logout];
  }
}

#pragma mark - helper methods

- (void)_logout
{
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^() {
    NSError *error;
    NSMutableDictionary *logOutDict = [NSMutableDictionary new];
    [logOutDict setObject:@"logout" forKey:@"action"];
    [logOutDict setObject:_userInfo.userName forKey:@"username"];
    [logOutDict setObject:_userInfo.password forKey:@"password"];
    [logOutDict setObject:_userInfo.userSession forKey:@"session"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:logOutDict
                                                       options:0
                                                         error:&error];
    
    NSURL *bitUnionLogInUrl = [NSURL URLWithString:@"http://out.bitunion.org/open_api/bu_logging.php"];
    
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
        NSLog(@"Log out success");
        
        dispatch_async(dispatch_get_main_queue(), ^(){
          JCBULogInViewController *logInVC = [[JCBULogInViewController alloc] initWithAutoLogIn:NO];
          [self presentViewController:logInVC animated:YES completion:nil];
        });

      } else {
        NSLog(@"Log out failed: %@", responseDict[@"msg"]);
      }
    } else {
      NSLog(@"Connection failed");
    }
    
  });
}

@end
