//
//  JCBULogOutViewController.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/13/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import "JCBULogOutViewController.h"
#import "JCBULogOutView.h"
#import "JCBUUser.h"

@interface JCBULogOutViewController ()

@end

@implementation JCBULogOutViewController
{
  JCBULogOutView *_logOutView;
  JCBUUser *_userInfo;
}

- (instancetype)initWithUserInfo:(JCBUUser *)userInfo;
{
  if (self = [super init]) {
    _logOutView = [[JCBULogOutView alloc] init];
    _userInfo = userInfo;
  }
  
  return self;
}

- (void)loadView
{
  self.view = _logOutView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Targe Action

- (void)didTapLogOut
{
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
    } else {
      NSLog(@"Log out failed: %@", responseDict[@"msg"]);
    }
  } else {
    NSLog(@"Connection failed");
  }
  
  [self dismissViewControllerAnimated:self completion:nil];
}

@end
