
//
//  JCBULogInViewController.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/12/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import "JCBULogInViewController.h"
#import "JCBULogInView.h"
#import "JCBULogOutViewController.h"
#import "JCBUUser.h"
#import "JCBUMainTabBarViewController.h"
#import "AppDelegate.h"

@interface JCBULogInViewController ()

@end

@implementation JCBULogInViewController
{
  JCBULogInView *_logInView;
  NSString *_defaultUserName;
  NSString *_defaultUserPassword;
  BOOL _autoLogIn;
}

- (instancetype)initWithAutoLogIn:(BOOL)autoLogIn
{
  if (self = [super init]) {
    _logInView = [[JCBULogInView alloc] init];
    _logInView.delegate = self;
    
    _autoLogIn = autoLogIn;
  }
  
  return self;
}

- (void)loadView
{
  
  self.view = _logInView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  [self _fetchUserDefault];
  
  _logInView.userNameTextField.text = _defaultUserName;
  _logInView.passwordTextField.text = _defaultUserPassword;
  
  if (_autoLogIn && _defaultUserName && _defaultUserPassword) {
    [self didTapLogIn];
  }
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

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  return YES;
}

#pragma mark - target action

- (void)didTapLogIn
{
  [_logInView.loadingIndicator startAnimating];
  
  [self _updateUserDefault];
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^() {
    NSError *error;
    NSMutableDictionary *logInDict = [NSMutableDictionary new];
    [logInDict setObject:@"login" forKey:@"action"];
    [logInDict setObject:_logInView.userNameTextField.text forKey:@"username"];
    [logInDict setObject:_logInView.passwordTextField.text forKey:@"password"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:logInDict
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
        NSLog(@"Log in success");
        
        JCBUUser *userInfo = [[JCBUUser alloc] initWithUserId:responseDict[@"uid"]
                                                    UserName:responseDict[@"username"]
                                                    password:_logInView.passwordTextField.text ?: @""
                                                    userSession:responseDict[@"session"]
                                                    status:responseDict[@"status"]
                                                    credit:responseDict[@"credit"]
                                                    lastActivity:responseDict[@"lastactivity"]];
      
        dispatch_async(dispatch_get_main_queue(), ^(){
          [_logInView.loadingIndicator stopAnimating];
          JCBUMainTabBarViewController *mainTabBarVC = [[JCBUMainTabBarViewController alloc] initWithUserInfo:userInfo];
          [self presentViewController:mainTabBarVC animated:YES completion:nil];
        });
      } else {
        dispatch_async(dispatch_get_main_queue(), ^(){
          [_logInView.loadingIndicator stopAnimating];
        });
        NSLog(@"Log in failed: %@", responseDict[@"msg"]);
      }
    } else {
      NSLog(@"Connection failed");
      dispatch_async(dispatch_get_main_queue(), ^{
        [_logInView.loadingIndicator stopAnimating];
      });
    }
  
  });
}

#pragma mark - helper methods

- (void)_fetchUserDefault
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  _defaultUserName = [defaults objectForKey:kJCBUUserName];
  _defaultUserPassword = [defaults objectForKey:kJCBUUserPassword];
}

- (void)_updateUserDefault
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setValue:_logInView.userNameTextField.text forKey:kJCBUUserName];
  [defaults setValue:_logInView.passwordTextField.text forKey:kJCBUUserPassword];
}

@end
