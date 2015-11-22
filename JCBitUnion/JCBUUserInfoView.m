//
//  JCBUUserInfoView.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/28/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import "JCBUUserInfoView.h"
#import "JCBUDetailedUserInfo.h"

@implementation JCBUUserInfoView
{
  CGFloat _imageHeight;
}

- (instancetype)init
{
  if (self = [super init]) {
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
    // [TODO] need a way to show users that he can scroll down or up
    _tableView = [[UITableView alloc] init];
    [self addSubview:_tableView];
    
    _loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:_loadingIndicator];
    
    self.backgroundColor = [UIColor whiteColor];
  }
  
  return self;
}

- (void)layoutSubviews
{
  CGRect bounds = self.bounds;
  _imageView.frame = CGRectMake(0, 30, bounds.size.width, _imageHeight > 0 ? _imageHeight : 200);
  _loadingIndicator.frame = CGRectMake((bounds.size.width - 32) / 2, 200, 32, 32);
  _tableView.frame = CGRectMake(0, (_imageHeight > 0 ? _imageHeight : 200) + 50, bounds.size.width, 300);
}

#pragma mark - helper methods

- (void)setImageHeight:(CGFloat)imageHeight
{
  _imageHeight = imageHeight;
}

@end
