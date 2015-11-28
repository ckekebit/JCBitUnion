//
//  JCBUImageDisplayView.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/25/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUImageDisplayView.h"

@implementation JCBUImageDisplayView

- (instancetype)initWithImage:(UIImage *)image
{
  if (self = [super init]) {
    _imageView = [[UIImageView alloc] init];
    _imageView.image = image;
    _imageView.frame = CGRectMake(0, 0, _imageView.image.size.width, _imageView.image.size.height);
    
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView addSubview:_imageView];
    
    _scrollView.contentSize = _imageView.image.size;
    
    [self addSubview:_scrollView];
   
    self.backgroundColor = [UIColor blackColor];
  }
  
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGRect bounds = self.bounds;
  
  _scrollView.frame = bounds;
}

@end
