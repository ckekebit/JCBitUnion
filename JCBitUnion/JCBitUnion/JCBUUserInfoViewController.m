//
//  JCBUUserInfoViewController.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/28/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import "JCBUUserInfoViewController.h"
#import "JCBUUserInfoView.h"
#import "JCBUUser.h"
#import "JCBUDetailedUserInfo.h"
#import <CoreImage/CIImage.h>

@interface JCBUUserInfoViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation JCBUUserInfoViewController
{
  JCBUUserInfoView *_userInfoView;
  JCBUUser *_userInfo;
  JCBUDetailedUserInfo *_detailedUserInfo;
  NSString *_postAuthor;
}

- (instancetype)initWithUserInfo:(JCBUUser *)userInfo postAuthor:(NSString *)postAuthor
{
  if (self = [super init]) {
    
    self.navigationItem.title = @"个人资料";
    
    _userInfoView = [[JCBUUserInfoView alloc] init];
    
    _userInfoView.tableView.delegate = self;
    _userInfoView.tableView.dataSource = self;
    
    _userInfo = userInfo;
    _postAuthor = postAuthor;
    
    [self _fetchDetailedUserInfo:_userInfo];
  }
  
  return  self;
}

- (void)loadView
{
  self.view = _userInfoView;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [_userInfoView.loadingIndicator startAnimating];
  
  self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [_userInfoView.tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                  reuseIdentifier:@"userInfoCell"];
  }
  switch (indexPath.row) {
    case 0:
    {
      cell.textLabel.text = @"uid";
      cell.detailTextLabel.text = _detailedUserInfo.userId;
      break;
    }
    case 1:
    {
      cell.textLabel.text = @"昵称";
      cell.detailTextLabel.text = [[_detailedUserInfo.userName stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      break;
    }
    case 2:
    {
      cell.textLabel.text = @"会员组";
      cell.detailTextLabel.text = _detailedUserInfo.status;
      break;
    }
    case 3:
    {
      cell.textLabel.text = @"积分";
      cell.detailTextLabel.text = _detailedUserInfo.credit ? : @"";
      break;
    }
    case 4:
    {
      cell.textLabel.text = @"注册日期";
      cell.detailTextLabel.text = [self _generateTimeString:[_detailedUserInfo.regDate doubleValue]];
      break;
    }
    case 5:
    {
      cell.textLabel.text = @"上次登录";
      cell.detailTextLabel.text = [self _generateTimeString:[_detailedUserInfo.lastVisit doubleValue]];
      break;
    }
    case 6:
    {
      cell.textLabel.text = @"主题数";
      cell.detailTextLabel.text = _detailedUserInfo.threadNum;
      break;
    }
    case 7:
    {
      cell.textLabel.text = @"回复数";
      cell.detailTextLabel.text = _detailedUserInfo.postNum;
      break;
    }
    case 8:
    {
      cell.textLabel.text = @"生日";
      cell.detailTextLabel.text = _detailedUserInfo.birthday;
      break;
    }
    case 9:
    {
      cell.textLabel.text = @"Email";
      cell.detailTextLabel.text = [[_detailedUserInfo.email stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      break;
    }
    case 10:
    {
      cell.textLabel.text = @"QQ";
      cell.detailTextLabel.text = _detailedUserInfo.oicq;
      break;
    }
    case 11:
    {
      cell.textLabel.text = @"MSN";
      cell.detailTextLabel.text = _detailedUserInfo.msn;
      break;
    }
    case 12:
    {
      cell.textLabel.text = @"个人主页";
      cell.detailTextLabel.text = _detailedUserInfo.site;
      break;
    }
    case 13:
    {
      cell.textLabel.text = @"ICQ";
      cell.detailTextLabel.text = _detailedUserInfo.icq;
      break;
    }
    case 14:
    {
      cell.textLabel.text = @"Yahoo";
      cell.detailTextLabel.text = _detailedUserInfo.yahoo;
      break;
    }
      
    default:
      break;
  }
  
  return cell;
}

#pragma mark - helper methods

- (void)_fetchUserAvatar:(JCBUDetailedUserInfo *)detailedUserInfo
{
  // method 1:
  NSString *decodedString = [[detailedUserInfo.avatar stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSString *urlString = [NSString stringWithFormat:@"%@%@", @"http://out.bitunion.org/", decodedString];
  NSURL *url = [NSURL URLWithString:urlString];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  
  // [TODO] It always fails and shows the default image. need to figure out why.
  // Maybe try the code for post detail view first
  NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
  NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:defaultConfigObject];
  NSURLSessionDataTask *dataTask =
  [urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (data) {
      UIImage *image = [UIImage imageWithData:data];
      if (!image) {
        image = [UIImage imageNamed:@"noavatar.gif"];
      }
      [_userInfoView setImageHeight:image.size.height];
      dispatch_async(dispatch_get_main_queue(), ^{
        [_userInfoView.loadingIndicator stopAnimating];
        _userInfoView.imageView.image = image;
        [_userInfoView.tableView reloadData];
        [_userInfoView setNeedsLayout];
      });
    }
  }];
  [dataTask resume];
  
  // method 2:
  //    [NSURLConnection sendAsynchronousRequest:request
  //                                       queue:[NSOperationQueue mainQueue]
  //                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
  //                             if (data) {
  //
  //                               [data writeToFile:@"/Users/jichen/Desktop/data.jpg" atomically:YES];
  //                               UIImage *image = [UIImage imageWithData:data];
  //                               dispatch_async(dispatch_get_main_queue(), ^() {
  //                                 _userInfoView.imageView.image = image;
  //                               });
  //                             }
  //                           }];
}

- (JCBUDetailedUserInfo *)_fetchDetailedUserInfo:(JCBUUser *)userInfo
{
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^() {
    NSError *error;
    NSMutableDictionary *detailedUserInfoDict = [NSMutableDictionary new];
    [detailedUserInfoDict setObject:@"profile" forKey:@"action"];
    [detailedUserInfoDict setObject:userInfo.userName forKey:@"username"];
    [detailedUserInfoDict setObject:userInfo.userSession forKey:@"session"];
    [detailedUserInfoDict setObject:_postAuthor ? _postAuthor : userInfo.userName forKey:@"queryusername"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:detailedUserInfoDict
                                                       options:0
                                                         error:&error];

    NSURL *bitUnionLogInUrl = [NSURL URLWithString:@"http://out.bitunion.org/open_api/bu_profile.php"];

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
        NSLog(@"Fetch user info success");
        NSDictionary *userInfoDict = responseDict[@"memberinfo"];
        JCBUDetailedUserInfo *detailedUserInfo = [[JCBUDetailedUserInfo alloc] initWithUserId:userInfoDict[@"uid"]
                                                                                       status:userInfoDict[@"status"]
                                                                                     userName:userInfoDict[@"username"]
                                                                                       avatar:userInfoDict[@"avatar"]
                                                                                      regDate:userInfoDict[@"regdate"]
                                                                                    lastVisit:userInfoDict[@"lastvisit"]
                                                                                     birthday:userInfoDict[@"bday"]
                                                                                    signature:userInfoDict[@"signature"]
                                                                                      postNum:userInfoDict[@"postnum"]
                                                                                    threadNum:userInfoDict[@"threadnum"]
                                                                                        email:userInfoDict[@"email"]
                                                                                         site:userInfoDict[@"site"]
                                                                                          icq:userInfoDict[@"icq"]
                                                                                         oicq:userInfoDict[@"oicq"]
                                                                                        yahoo:userInfoDict[@"yahoo"]
                                                                                          msn:userInfoDict[@"msn"]
                                                                                       credit:userInfoDict[@"credit"]];
        _detailedUserInfo = detailedUserInfo;
        
        [self _fetchUserAvatar:detailedUserInfo];
      } else {
        NSLog(@"Fetch user info failed: %@", responseDict[@"msg"]);
      }
    } else {
      NSLog(@"Server failed when fetching user info");
    }
  });

  return nil;
}

- (NSString *)_generateTimeString:(double)unixTimeStamp
{
  if (unixTimeStamp == 0) {
    return @"";
  }
  
  NSTimeInterval _interval = unixTimeStamp;
  NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
  NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
  [formatter setLocale:[NSLocale currentLocale]];
  [formatter setDateFormat:@"yyyy-MM-dd"];
  NSString *dateString = [formatter stringFromDate:date];
  return dateString;
}

@end
