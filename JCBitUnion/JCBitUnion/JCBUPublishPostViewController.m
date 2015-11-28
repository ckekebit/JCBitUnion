//
//  JCBUPublishPostViewController.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/19/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUPublishPostViewController.h"
#import "JCBUPublishPostView.h"
#import "JCBUUser.h"

@interface JCBUPublishPostViewController ()

@end

@implementation JCBUPublishPostViewController
{
  JCBUUser *_userInfo;
  NSString *_postId;
  JCBUPublishPostView *_publishPostView;
}

- (instancetype)initWithUserInfo:(JCBUUser *)userInfo postId:(NSString *)postId subject:(NSString *)subject
{
  if (self = [super init]) {
    _userInfo = userInfo;
    _postId = postId;
    _publishPostView = [[JCBUPublishPostView alloc] initWithSubject:subject];
    
    self.navigationItem.title = @"回复帖子";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(_didTapPost:)];
  }
  
  return self;
}

- (void)loadView
{
  self.view = _publishPostView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.edgesForExtendedLayout = UIRectEdgeNone;
  [_publishPostView.textView becomeFirstResponder];
}

#pragma mark - Targe Action

// [TODO] after post is successfully posted, show it in the post thread
- (void)_didTapPost:(id)sender
{
  [_publishPostView.loadingIndicator startAnimating];
  self.navigationItem.rightBarButtonItem.enabled = NO;
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^() {
    NSError *error;
    NSMutableDictionary *publishPostDict = [NSMutableDictionary new];
    [publishPostDict setObject:_userInfo.userName forKey:@"username"];
    [publishPostDict setObject:_userInfo.userSession forKey:@"session"];
    [publishPostDict setObject:@"newreply" forKey:@"action"];
    [publishPostDict setObject:_postId forKey:@"tid"];
    [publishPostDict setObject:@"0" forKey:@"attachment"];
    [publishPostDict setObject:_publishPostView.textView.text forKey:@"message"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:publishPostDict
                                                       options:0
                                                         error:&error];
    
    NSMutableString *jsonString = [NSMutableString new];
    [jsonString appendString:[[NSMutableString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
    
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://out.bitunion.org/open_api/bu_newpost.php"]];
    
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    
    NSMutableString *header = [NSMutableString new];
    [header appendFormat:@"\r\n--AaB03x\r\n"];
    NSMutableString *space = [NSMutableString new];
    [space appendFormat:@"\r\n\r\n"];
    NSMutableString *footer = [NSMutableString new];
    [footer appendFormat:@"\r\n--AaB03x\r\n"];
    
    [myRequestData appendData:[header dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData appendData:[@"Content-Disposition:form-data; name=\"json\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData appendData:[space dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData appendData:jsonData];
    [myRequestData appendData:[footer dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc] initWithFormat:@"multipart/form-data; boundary=AaB03x"];
    [request setValue:content forHTTPHeaderField:@"Content-type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%li", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    
    NSHTTPURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"Response status code is: %li", response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      NSString *responseData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
      NSLog(@"Response ==> %@", responseData);
      
      dispatch_async(dispatch_get_main_queue(), ^() {
        [_publishPostView.loadingIndicator stopAnimating];
        self.navigationItem.rightBarButtonItem.enabled = YES;
        [self.navigationController popViewControllerAnimated:YES];
      });
      
    } else {
      dispatch_async(dispatch_get_main_queue(), ^() {
        [_publishPostView.loadingIndicator stopAnimating];
      });
      NSLog(@"Connection failed");
    }
    
  });
}

@end
