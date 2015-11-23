//
//  JCBUPublishPostView.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/19/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUPublishPostView.h"

static const CGFloat kTopVerticalPadding = 5.0;
static const CGFloat kEdgeHorizontalPadding = 5.0;
static const CGFloat kSubjectViewHeight = 50;

@implementation JCBUPublishPostView

- (instancetype)initWithSubject:(NSString *)subject
{
  if (self = [super init]) {
    _subjectLabel = [[UILabel alloc] init];
    _subjectLabel.textColor = [UIColor blackColor];
    _subjectLabel.font = [UIFont boldSystemFontOfSize:14];
    _subjectLabel.numberOfLines = 2;
    _subjectLabel.text = [NSString stringWithFormat:@"Re: %@", subject];
    [self addSubview:_subjectLabel];
    
    _separator = [[UIView alloc] init];
    _separator.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_separator];
    
    _textView = [[UITextView alloc] init];
    _textView.font = [UIFont systemFontOfSize:14];
    [self addSubview:_textView];
    
    _loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:_loadingIndicator];
    
    self.backgroundColor = [UIColor whiteColor];
  }
  
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGRect bounds = self.bounds;
  CGFloat yOffset = kTopVerticalPadding;
  
  _subjectLabel.frame = CGRectMake(kEdgeHorizontalPadding, yOffset, bounds.size.width - kEdgeHorizontalPadding * 2, kSubjectViewHeight);
  yOffset += kSubjectViewHeight;

  yOffset += 10;
  _separator.frame = CGRectMake(0, yOffset, bounds.size.width, 1.0);
  yOffset += 1;
  
  yOffset += 10;
  _textView.frame = CGRectMake(kEdgeHorizontalPadding, yOffset, bounds.size.width - kEdgeHorizontalPadding * 2, 200);
  
  _loadingIndicator.frame = CGRectMake((bounds.size.width - 32) / 2, 200, 32, 32);
}

@end
