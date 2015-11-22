//
//  JCBULogOutView.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/13/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import "JCBULogOutView.h"

@implementation JCBULogOutView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
  if (self = [super init]) {
    _logOutButton = [[UIButton alloc] init];
    _logOutButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_logOutButton setTitle:@"Log Out" forState:UIControlStateNormal];
    [_logOutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_logOutButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3] forState:UIControlStateHighlighted];
    [_logOutButton addTarget:nil action:@selector(didTapLogOut) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_logOutButton];
    
    self.backgroundColor = [UIColor whiteColor];
  }
  
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGRect bounds = self.bounds;
  _logOutButton.frame = CGRectMake(20, 100, bounds.size.width - 40, 32);
}

@end
