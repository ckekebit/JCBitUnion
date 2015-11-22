//
//  JCBUFirstPageView.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 10/4/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUFirstPageView.h"

@implementation JCBUFirstPageView

- (instancetype)init
{
  if (self = [super init]) {
    _tableView = [[UITableView alloc] init];
    [self addSubview:_tableView];
    
    _loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:_loadingIndicator];
  }
  
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGRect bounds = self.bounds;
  _tableView.frame = bounds;
  _loadingIndicator.frame = CGRectMake((bounds.size.width - 32) / 2, (bounds.size.height - 32) / 2, 32, 32);
}

@end
