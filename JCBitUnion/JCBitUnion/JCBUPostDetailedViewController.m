//
//  JCBUPostDetailedViewController.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 10/12/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUPostDetailedViewController.h"
#import "JCBUPostDetailedInfo.h"
#import "JCBUPostDetailedView.h"
#import "JCBUUser.h"
#import "JCBUPostDetailCell.h"
#import "JCBUPostDetailedHeader.h"
#import "JCBUPostDetailedBody.h"
#import "JCBUPostNavigationView.h"
#import "JCBUUserInfoViewController.h"
#import "JCBUPublishPostViewController.h"
#import "JCBUImageDisplayViewController.h"
#import "JCBUPostDetailedAttachment.h"

static const CGFloat kPostSubjectHeight = 50.0;

@interface JCBUPostDetailedViewController () <UITableViewDataSource, UITableViewDelegate, JCBUPostDetailedHeaderDelegate>

@end

@implementation JCBUPostDetailedViewController
{
  JCBUPostDetailedView *_postDetailedView;
  NSMutableArray *_postDetailedInfos;
  JCBUUser *_userInfo;
  NSString *_postId;
  NSString *_postSubject;
  NSString *_bodyText;
  NSString *_attachment;
  
  NSString *_referencePostAuthor;
  NSString *_referencePostTime;
  NSString *_referencePostBodyText;
  NSString *_postBodyText;
  
  // page number starts from 1
  NSInteger _currentPage;
  NSInteger _postReplyPageNumber;
  
  UIRefreshControl *_ptrControl;
}

// [TODO] add PTR
- (instancetype)initWithUserInfo:(JCBUUser *)userInfo postId:(NSString *)postId postSubject:(NSString *)postSubject forumSubject:(NSString *)forumSubject
{
  if (self = [super init]) {
    self.navigationItem.title = [[forumSubject stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"new_post.png"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(_didTapNewPost:)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    _postDetailedView = [[JCBUPostDetailedView alloc] init];
    _postDetailedView.tableView.dataSource = self;
    _postDetailedView.tableView.delegate = self;
    
    _userInfo = userInfo;
    _postId = postId;
    _postSubject = [[postSubject stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    _postDetailedInfos = [NSMutableArray new];
    
    
    _currentPage = 0;
    _postReplyPageNumber = 0;
    
    self.hidesBottomBarWhenPushed = YES;
    
    _ptrControl = [[UIRefreshControl alloc] init];
    [_ptrControl addTarget:self
                    action:@selector(_pullToRefreshFirstPage)
          forControlEvents:UIControlEventValueChanged];
    [_ptrControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@"Release to refresh"]];
    
    [self _fetchPostReplyPageNumber];
    [self _fetchPostDetailedInfoFrom:0 To:20 increasePageNumBy:1];
  }
  
  return self;
}

- (void)loadView
{
  self.view = _postDetailedView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  self.edgesForExtendedLayout = UIRectEdgeNone;
  
  UITableViewController *tableVC = [[UITableViewController alloc] init];
  tableVC.tableView = _postDetailedView.tableView;
  
  tableVC.refreshControl = _ptrControl;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == 0) {
    return 56;
  }
  
  CGFloat height = [JCBUPostDetailedBody postBodyHeightWithReferencePostAuthor:_referencePostAuthor
                                                             referencePostTime:_referencePostTime
                                                         referencePostBodyText:_referencePostBodyText
                                                                  postBodyText:_postBodyText];
  
  CGFloat cellHeight = height + kPostSubjectHeight + (_attachment ? 250 : 0);
  
  return cellHeight;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _postDetailedInfos.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == 0) {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"common"];
    cell.textLabel.text = _postSubject;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.textColor = [UIColor colorWithRed:88.0/255 green:88.0/255 blue:255.0/255 alpha:1];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    return cell;
  }
  
  _attachment = nil;
  
  JCBUPostDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postDetailCell"];
  NSString *name = _postDetailedInfos.count == 0 ? nil : [[((JCBUPostDetailedInfo *)_postDetailedInfos[indexPath.row - 1]).author stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
  NSString *timestamp = _postDetailedInfos.count == 0 ? nil : ((JCBUPostDetailedInfo *)_postDetailedInfos[indexPath.row - 1]).dateline;
  NSString *dateString = nil;
  if (timestamp) {
    NSTimeInterval _interval = [timestamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    dateString = [formatter stringFromDate:date];
  }
  
  NSString *bodyText = _postDetailedInfos.count == 0 ? nil : ((JCBUPostDetailedInfo *)_postDetailedInfos[indexPath.row - 1]).message;
  _bodyText = [[bodyText stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  [self _parseBodyText];
  
  NSString *attachment = _postDetailedInfos.count == 0 ? nil : ((JCBUPostDetailedInfo *)_postDetailedInfos[indexPath.row - 1]).attachment;
  if (attachment && attachment != (id)[NSNull null]) {
    NSMutableString *partialUrl = [NSMutableString stringWithString:@"http://out.bitunion.org/"];
    [partialUrl appendString:[[attachment stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    _attachment = partialUrl;
  }
  
//  if (!cell) {
    cell = [[JCBUPostDetailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:@"postDetailCell"
                                               image:nil
                                                name:name
                                         floorNumber:[NSString stringWithFormat:@"%ld 楼", (_currentPage - 1) * 20 + indexPath.row]
                                           timestamp:dateString
                                 referencePostAuthor:_referencePostAuthor
                                   referencePostTime:_referencePostTime
                               referencePostBodyText:_referencePostBodyText
                                        postBodyText:_postBodyText
                                          attachment:_attachment];
  
//  }
//  
//  [cell initializeCellContentWithImage:nil
//                                  name:name
//                           floorNumber:[NSString stringWithFormat:@"%ld 楼", indexPath.row + 1]
//                         timeStampText:dateString
//                  referencedPostAuthor:_referencePostAuthor
//                     referencePostTime:_referencePostTime
//                 referencePostBodyText:_referencePostBodyText
//                          postBodyText:_postBodyText];
  
  // Fetch avatar and update the cell
  // [TODO] add cache support. use NSCache: http://blog.csdn.net/willyang519/article/details/41833293
  cell.postDetailedHeader.imageView.image = nil;
  cell.postDetailedHeader.delegate = self;
  cell.postDetailedAttachment.delegate = self;
  
  NSString *decodedString = nil;
  NSString *avatarUrl = ((JCBUPostDetailedInfo *)_postDetailedInfos[indexPath.row - 1]).avatar;
  if (_postDetailedInfos.count > 0 && avatarUrl) {
    decodedString = [[avatarUrl stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  }
  if (decodedString.length > 0) {
    NSRange range1 = [decodedString rangeOfString:@"src"];
    NSRange range2 = [decodedString rangeOfString:@"border"];
    if (range1.location == NSNotFound || range2.location == NSNotFound ) {
      UIImage *image = [UIImage imageNamed:@"noavatar.gif"];
      cell.postDetailedHeader.imageView.image = image;
    } else {
      NSRange range3 = NSMakeRange(10, range2.location - range1.location - 4 - 4);
      NSLog(@"Working on row %li, the decoded string is: %@", indexPath.row, decodedString);
      NSString *actualImagePath = [decodedString substringWithRange:range3];
      NSString *urlString = [NSString stringWithFormat:@"%@%@", @"http://out.bitunion.org/", actualImagePath];
      NSURL *url = [NSURL URLWithString:urlString];
      
      NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
          UIImage *image = [UIImage imageWithData:data];
          if (!image) {
            image = [UIImage imageNamed:@"noavatar.gif"];
          }
          dispatch_async(dispatch_get_main_queue(), ^{
            JCBUPostDetailCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            NSLog(@"Current row is: %li", indexPath.row);
            cell.postDetailedHeader.imageView.image = image;
          });
        }
      }];
      [task resume];
    }
  } else {
    UIImage *image = [UIImage imageNamed:@"noavatar.gif"];
    cell.postDetailedHeader.imageView.image = image;
  }

  if (_attachment) {
    NSLog(@"Fetching attachment: %@", _attachment);
    NSURL *url = [NSURL URLWithString:_attachment];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      if (data) {
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
          JCBUPostDetailCell *cell = [tableView cellForRowAtIndexPath:indexPath];
          cell.postDetailedAttachment.attachmentView.image = image;
        });
      }
    }];
    [task resume];
  }
  
  return cell;
}

#pragma mark - helper methods

- (void)_fetchPostReplyPageNumber
{
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^() {
    NSError *error;
    NSMutableDictionary *fetchPostDict = [NSMutableDictionary new];
    [fetchPostDict setObject:_userInfo.userName forKey:@"username"];
    [fetchPostDict setObject:_userInfo.userSession forKey:@"session"];
    [fetchPostDict setObject:_postId forKey:@"tid"];
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
        _postReplyPageNumber = [responseDict[@"tid_sum"] intValue] / 20 + 1;
      }
    } else {
      NSLog(@"Connection failed");
    }
    
  });
}

- (void)_fetchPostDetailedInfoFrom:(NSInteger)fromIndex To:(NSInteger)toIndex increasePageNumBy:(NSInteger)number
{
  [_postDetailedView.loadingIndicator startAnimating];
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^() {
    NSError *error;
    NSMutableDictionary *fetchPostDict = [NSMutableDictionary new];
    [fetchPostDict setObject:@"post" forKey:@"action"];
    [fetchPostDict setObject:_userInfo.userName forKey:@"username"];
    [fetchPostDict setObject:_userInfo.userSession forKey:@"session"];
    [fetchPostDict setObject:_postId forKey:@"tid"];
    [fetchPostDict setObject:[NSString stringWithFormat:@"%li", fromIndex] forKey:@"from"];
    [fetchPostDict setObject:[NSString stringWithFormat:@"%li", toIndex] forKey:@"to"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:fetchPostDict
                                                       options:0
                                                         error:&error];

    NSURL *bitUnionLogInUrl = [NSURL URLWithString:@"http://out.bitunion.org/open_api/bu_post.php"];

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
        NSLog(@"Fetching post info success");
        
        // Update page number after fetching data successfully
        _currentPage += number;
        if (_postDetailedInfos.count > 0) {
          [_postDetailedInfos removeAllObjects];
        }
        for (NSDictionary *dict in responseDict[@"postlist"]) {
          JCBUPostDetailedInfo *postDetailedInfo = [[JCBUPostDetailedInfo alloc] initWithAaid:dict[@"aaid"]
                                                                                          aid:dict[@"aid"]
                                                                                   attachment:dict[@"attachment"]
                                                                                       author:dict[@"author"]
                                                                                     authorid:dict[@"authorid"]
                                                                                       avatar:dict[@"avatar"]
                                                                                    bbcodeoff:dict[@"bbcodeoff"]
                                                                               creditsrequire:dict[@"creditsrequire"]
                                                                                     dateline:dict[@"dateline"]
                                                                                    downloads:dict[@"downloads"]
                                                                                         epid:dict[@"epid"]
                                                                                          fid:dict[@"fid"]
                                                                                     filename:dict[@"filename"]
                                                                                     filesize:dict[@"filesize"]
                                                                                     filetype:dict[@"filetype"]
                                                                                         icon:dict[@"icon"]
                                                                                     lastedit:dict[@"lastedit"]
                                                                                     markpost:dict[@"markpost"]
                                                                                      message:dict[@"message"]
                                                                                  parseurloff:dict[@"parseurloff"]
                                                                                          pid:dict[@"pid"]
                                                                                      pstatus:dict[@"pstatus"]
                                                                                         rate:dict[@"rate"]
                                                                                    ratetimes:dict[@"ratetimes"]
                                                                                        score:dict[@"score"]
                                                                                    smileyoff:dict[@"smileyoff"]
                                                                                      subject:dict[@"subject"]
                                                                                          tid:dict[@"tid"]
                                                                                          uid:dict[@"uid"]
                                                                                     username:dict[@"username"]
                                                                                       usesig:dict[@"usesig"]];
          [_postDetailedInfos addObject:postDetailedInfo];
        }

        dispatch_async(dispatch_get_main_queue(), ^(){
          [_postDetailedView.loadingIndicator stopAnimating];
          self.navigationItem.rightBarButtonItem.enabled = YES;
          _postDetailedView.postNavigationView.pageLabel.text = [NSString stringWithFormat:@"%li / %li", _currentPage, _postReplyPageNumber];
          _postDetailedView.postNavigationView.leftButton.enabled = _currentPage > 1 ? YES : NO;
          _postDetailedView.postNavigationView.leftMostButton.enabled = _currentPage > 1 ? YES : NO;
          _postDetailedView.postNavigationView.rightButton.enabled = (_currentPage < _postReplyPageNumber) ? YES : NO;
          _postDetailedView.postNavigationView.rightMostButton.enabled = (_currentPage < _postReplyPageNumber) ? YES : NO;
          [_postDetailedView.tableView reloadData];
          [_postDetailedView setNeedsLayout];
        });
      } else {
        dispatch_async(dispatch_get_main_queue(), ^(){
          [_postDetailedView.loadingIndicator stopAnimating];
        });
        NSLog(@"Fetching post info failed: %@", responseDict[@"msg"]);
      }
    } else {
      dispatch_async(dispatch_get_main_queue(), ^(){
        [_postDetailedView.loadingIndicator stopAnimating];
      });
      NSLog(@"Connection failed");
    }
    
  });
}

- (void)_parseBodyText
{
  NSString *postBodyText;
  if (_bodyText && [_bodyText rangeOfString:@"查看原帖"].location != NSNotFound) {
    NSRange range1 = [_bodyText rangeOfString:@"<b>"];
    NSRange range2 = [_bodyText rangeOfString:@"</b>"];
    if (range1.location != NSNotFound && range2.location != NSNotFound) {
      NSRange authorTextRange = NSMakeRange(range1.location + 1 + 2, range2.location - range1.location - 1 - 2);
      _referencePostAuthor = [_bodyText substringWithRange:authorTextRange];
    }
    
    NSRange range3 = [_bodyText rangeOfString:@"<br />"];
    if (range3.location != NSNotFound) {
      NSRange timeRange = NSMakeRange(range2.location + 1 + 4, range3.location - range2.location - 1 - 4);
      NSString *timeString = [_bodyText substringWithRange:timeRange];
      // Replace the "+" between date and time with " "
      _referencePostTime = [timeString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    }
    
    NSRange range4 = [_bodyText rangeOfString:@"</table>"];
    if (range4.location != NSNotFound) {
      NSRange bodyTextRange = NSMakeRange(range3.location + 1 + 7, range4.location - range3.location - 1 - 18);
      NSString *bodyText = [_bodyText substringWithRange:bodyTextRange];
      _referencePostBodyText = [self _cleanUpText:bodyText];
    }
    
    NSRange range5 = [_bodyText rangeOfString:@"</table>" options:NSBackwardsSearch];
    if (range5.location != NSNotFound) {
      NSRange postBodyTextRange = NSMakeRange(range5.location + 21, _bodyText.length - range5.location - 21);
      postBodyText = [_bodyText substringWithRange:postBodyTextRange];
    }
  } else {
    _referencePostAuthor = nil;
    _referencePostTime = nil;
    _referencePostBodyText = nil;
    postBodyText = _bodyText;
  }

  _postBodyText = [self _cleanUpText:postBodyText];
}

- (NSString *)_cleanUpText:(NSString *)text
{
  // clean up html special chars
  text = [text stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
  text = [text stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
  text = [text stringByReplacingOccurrencesOfString:@"&nbsp" withString:@" "];
  text = [text stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
  text = [text stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
  text = [text stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
  
  // remove emotion icons
  text = [self _removeEmbeddedHTMLTags:text];
  
  return text;
}

- (NSString *)_removeEmbeddedHTMLTags:(NSString *)text
{
  // Remove all tags
  while (text && [text rangeOfString:@"<"].location != NSNotFound) {
    NSRange range1 = [text rangeOfString:@"<"];
    NSRange range2 = [text rangeOfString:@">" options:NSLiteralSearch range:NSMakeRange(range1.location, text.length - range1.location)];
    if (range1.length == NSNotFound || range2.location == NSNotFound) {
      break;
    }
    text = [text stringByReplacingCharactersInRange:NSMakeRange(range1.location, range2.location - range1.location + 1) withString:@""];
  }
  
  if (text) {
    NSMutableString *result = [NSMutableString stringWithString:text];
    // Add a new line before "..:: From BIT-Union....."
    if (text && [text rangeOfString:@"From BIT-Union"].location != NSNotFound) {
      NSRange range = [text rangeOfString:@"From BIT-Union"];
      [result insertString:@"\n\n" atIndex:range.location - 5];
    }
    
    return result;
  }
  
  return nil;
}

- (void)_pullToRefreshFirstPage
{
  [self _fetchPostDetailedInfoFrom:(_currentPage - 1) * 20 To:_currentPage * 20 increasePageNumBy:0];
  [_ptrControl endRefreshing];
}

#pragma mark - Post page navigation methods

- (void)didTapPreviousPageButton
{
  if (_currentPage - 2 >= 0) {
    [self _fetchPostDetailedInfoFrom:(_currentPage - 2) * 20 To:(_currentPage - 1) * 20 increasePageNumBy:-1];
  }
}

- (void)didTapNextPageButton
{
  [self _fetchPostDetailedInfoFrom:_currentPage * 20 To:(_currentPage + 1) * 20 increasePageNumBy:1];
}

- (void)didTapLeftMostPageButton
{
  [self _fetchPostDetailedInfoFrom:0 To:20 increasePageNumBy:-(_currentPage - 1)];
}

- (void)didTapRightMostPageButton
{
  [self _fetchPostDetailedInfoFrom:(_postReplyPageNumber - 1) * 20 To:_postReplyPageNumber * 20 increasePageNumBy:(_postReplyPageNumber - _currentPage)];
}

#pragma mark - JCBUPostDetailedHeaderDelegate

- (void)didTapAuthor:(NSString *)commentAuthor
{
  JCBUUserInfoViewController *userInfoViewController = [[JCBUUserInfoViewController alloc] initWithUserInfo:_userInfo postAuthor:commentAuthor];
  [self.navigationController pushViewController:userInfoViewController animated:YES];
}

- (void)didTapProfilePicture:(UIImage *)image withFrame:(CGRect)viewFrame
{
  JCBUImageDisplayViewController *imageDisplayVC = [[JCBUImageDisplayViewController alloc] initWithImage:image withFrame:viewFrame];
  
  [self presentViewController:imageDisplayVC animated:NO completion:nil];
}

#pragma mark - JCBUPostDetailedAttachmentDelegate

- (void)didTapAttachmentView:(UIImage *)image withFrame:(CGRect)imageFrame
{
  JCBUImageDisplayViewController *imageDisplayVC = [[JCBUImageDisplayViewController alloc] initWithImage:image withFrame:imageFrame];
  
  [self presentViewController:imageDisplayVC animated:NO completion:nil];
}

#pragma mark - Target Action

- (void)_didTapNewPost:(id)sender
{
  JCBUPublishPostViewController *publishPostVC = [[JCBUPublishPostViewController alloc] initWithUserInfo:_userInfo postId:_postId subject:_postSubject];
  [self.navigationController pushViewController:publishPostVC animated:YES];
}

@end
