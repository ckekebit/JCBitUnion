//
//  JCBUForumThreadView.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/14/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUForumThreadView.h"
#import "JCBUPostNavigationView.h"

static const CGFloat kPostNavigationViewHeight = 30.0;

@implementation JCBUForumThreadView

- (instancetype)init
{
  if (self = [super init]) {
    _tableView = [[UITableView alloc] init];
    [self addSubview:_tableView];
    
    _loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:_loadingIndicator];
    
    _postNavigationView = [[JCBUPostNavigationView alloc] init];
    [self addSubview:_postNavigationView];
    
    self.backgroundColor = [UIColor whiteColor];
  }
  
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGRect bounds = self.bounds;
  
  _loadingIndicator.frame = CGRectMake((bounds.size.width - 32) / 2, 200, 32, 32);
  
  _tableView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height - kPostNavigationViewHeight);
  
  _postNavigationView.frame = CGRectMake(0, bounds.size.height - kPostNavigationViewHeight, bounds.size.width, kPostNavigationViewHeight);
}

@end
