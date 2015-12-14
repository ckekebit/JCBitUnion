//
//  JCBUReferencedPostView.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 10/18/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUReferencedPostView.h"

static const CGFloat kHorizontalPadding = 5.0;
static const CGFloat kAuthorLabelAndTimeLabelPadding = 5.0;
static const CGFloat kVerticalPadding = 5.0;

@implementation JCBUReferencedPostView
{
  UILabel *_authorLabel;
  UILabel *_timeLabel;
  UITextView *_referencedPostBodyView;
}

- (instancetype)initWithAuthor:(NSString *)author
                          time:(NSString *)timestamp
                referencedPost:(NSString *)referencedPost
{
  if (self = [super init]) {
    _authorLabel = [[UILabel alloc] init];
    _authorLabel.font = [UIFont boldSystemFontOfSize:14];
    _authorLabel.text = author;
    [self addSubview:_authorLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.text = timestamp;
    [self addSubview:_timeLabel];
    
    _referencedPostBodyView = [[UITextView alloc] init];
    _referencedPostBodyView.font = [UIFont systemFontOfSize:14];
    _referencedPostBodyView.text = referencedPost;
    _referencedPostBodyView.backgroundColor = [UIColor clearColor];
    _referencedPostBodyView.editable = NO;
    _referencedPostBodyView.scrollEnabled = NO;
    [self addSubview:_referencedPostBodyView];
    
    self.layer.borderColor = [UIColor colorWithRed:226.0/255 green:226.0/255 blue:226.0/255 alpha:1].CGColor;
    self.layer.borderWidth = 2.0f;
    
    self.backgroundColor = [UIColor colorWithRed:247.0/255 green:249.0/255 blue:1.0 alpha:1];
  }
  
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGRect bounds = self.bounds;
  CGFloat yOffset = kVerticalPadding;
  
  [_authorLabel sizeToFit];
  CGRect frame = _authorLabel.frame;
  _authorLabel.frame = CGRectMake(kHorizontalPadding, yOffset, frame.size.width, frame.size.height);
  
  [_timeLabel sizeToFit];
  CGFloat timeLabelXOffset = kHorizontalPadding + frame.size.width + kAuthorLabelAndTimeLabelPadding;
  _timeLabel.frame = CGRectMake(timeLabelXOffset, yOffset, _timeLabel.frame.size.width, _timeLabel.frame.size.height);
  yOffset += _timeLabel.frame.size.height;
  
  yOffset += kVerticalPadding;
  CGSize viewSize = [_referencedPostBodyView sizeThatFits:CGSizeMake(bounds.size.width - kHorizontalPadding * 2, 10000)];
  _referencedPostBodyView.frame = CGRectMake(kHorizontalPadding, yOffset, viewSize.width, viewSize.height);
}

- (void)initializeContentWithAuthor:(NSString *)author
                               time:(NSString *)timestamp
                     referencedPost:(NSString *)referencedPost
{
  _authorLabel.text = author;
  _timeLabel.text = timestamp;
  _referencedPostBodyView.text = referencedPost;
}

+ (CGFloat)desiredHeightWithReferencePostAuthor:referencePostAuthor
                              referencePostTime:referencePostTime
                          referencePostBodyText:referencePostBodyText
{
  CGFloat height = kVerticalPadding;
  UILabel *authorLabel = [[UILabel alloc] init];
  authorLabel.font = [UIFont boldSystemFontOfSize:14];
  authorLabel.text = referencePostAuthor;
  
  [authorLabel sizeToFit];
  height += authorLabel.frame.size.height;
  height += kVerticalPadding;
  
  UITextView *postBodyView = [[UITextView alloc] init];
  postBodyView.font = [UIFont systemFontOfSize:14];
  postBodyView.text = referencePostBodyText;
  CGSize viewSize = [postBodyView sizeThatFits:CGSizeMake([[UIScreen mainScreen] bounds].size.width - 20.0 - kHorizontalPadding * 2, 10000)];
  height += viewSize.height;
  
  return height;
}

@end
