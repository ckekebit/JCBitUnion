//
//  JCBUPostNavigationView.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/10/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUPostNavigationView.h"

static const CGFloat kPageLabelWidth = 120;
static const CGFloat kButtonHorizontalPadding = 20;
static const CGFloat kButtonWidth = 30;

@implementation JCBUPostNavigationView

- (instancetype)init
{
  if (self = [super init]) {
    _leftButton = [[UIButton alloc] init];
    [_leftButton setImage:[UIImage imageNamed:@"left_arrow.png"] forState:UIControlStateNormal];
    [_leftButton addTarget:nil action:@selector(didTapPreviousPageButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftButton];
    
    _rightButton = [[UIButton alloc] init];
    [_rightButton setImage:[UIImage imageNamed:@"right_arrow.png"] forState:UIControlStateNormal];
    [_rightButton addTarget:nil action:@selector(didTapNextPageButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightButton];
    
    _leftMostButton = [[UIButton alloc] init];
    [_leftMostButton setImage:[UIImage imageNamed:@"double_left.png"] forState:UIControlStateNormal];
    [_leftMostButton addTarget:nil action:@selector(didTapLeftMostPageButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftMostButton];
    
    _rightMostButton = [[UIButton alloc] init];
    [_rightMostButton setImage:[UIImage imageNamed:@"double_right.png"] forState:UIControlStateNormal];
    [_rightMostButton addTarget:nil action:@selector(didTapRightMostPageButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightMostButton];
    
    _pageLabel = [[UILabel alloc] init];
    _pageLabel.font = [UIFont systemFontOfSize:14];
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_pageLabel];
    
    self.backgroundColor = [UIColor colorWithRed:226/255 green:226/255 blue:226/255 alpha:0];
  }
  
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGRect bounds = self.bounds;
  
  _pageLabel.frame = CGRectMake((bounds.size.width - kPageLabelWidth) / 2.0, 0, kPageLabelWidth, bounds.size.height);
  _leftButton.frame = CGRectMake(kButtonHorizontalPadding + 80, 0, kButtonWidth, bounds.size.height);
  _rightButton.frame = CGRectMake(bounds.size.width - kButtonWidth - kButtonHorizontalPadding - 80, 0, kButtonWidth, bounds.size.height);
  
  _leftMostButton.frame = CGRectMake(kButtonHorizontalPadding, 0, kButtonWidth, bounds.size.height);
  _rightMostButton.frame = CGRectMake(bounds.size.width - kButtonWidth - kButtonHorizontalPadding, 0, kButtonWidth, bounds.size.height);
}

@end
