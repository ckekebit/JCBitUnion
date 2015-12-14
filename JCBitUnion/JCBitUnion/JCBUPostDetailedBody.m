//
//  JCBUPostDetailedBody.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 10/13/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUPostDetailedBody.h"
#import "JCBUReferencedPostView.h"

static const CGFloat kPostTextBodyEdgePadding = 10.0;

@implementation JCBUPostDetailedBody
{
  NSString *_referencePostAuthor;
  NSString *_referencePostTime;
  NSString *_referencePostBodyText;
}

- (instancetype)initWithReferencePostAuthor:(NSString *)referencePostAuthor
                          referencePostTime:(NSString *)referencePostTime
                      referencePostBodyText:(NSString *)referencePostBodyText
                               postBodyText:(NSString *)postBodyText
{
  if (self = [super init]) {
    if (referencePostAuthor) {
      _referencedPostView = [[JCBUReferencedPostView alloc] initWithAuthor:referencePostAuthor
                                                                      time:referencePostTime
                                                            referencedPost:referencePostBodyText];
      [self addSubview:_referencedPostView];
    }
    
    _textView = [[UITextView alloc] init];
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.text = postBodyText;
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.scrollEnabled = NO;
    _textView.backgroundColor = [UIColor clearColor];
    _textView.editable = NO;
    [self addSubview:_textView];
    
    _referencePostAuthor = referencePostAuthor;
    _referencePostTime = referencePostTime;
    _referencePostBodyText = referencePostBodyText;
    
    self.backgroundColor = [UIColor whiteColor];
  }
  
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGRect bounds = self.bounds;
  
  CGFloat postViewHeight;
  if (_referencedPostView) {
    postViewHeight = [JCBUReferencedPostView desiredHeightWithReferencePostAuthor:_referencePostAuthor
                                                              referencePostTime:_referencePostTime
                                                          referencePostBodyText:_referencePostBodyText];
    _referencedPostView.frame = CGRectMake(kPostTextBodyEdgePadding, 0, bounds.size.width - kPostTextBodyEdgePadding * 2, postViewHeight);
  }
  
  CGSize textViewSize = [_textView sizeThatFits:CGSizeMake(bounds.size.width - kPostTextBodyEdgePadding * 2, bounds.size.height)];
  _textView.frame = CGRectMake(kPostTextBodyEdgePadding, postViewHeight, textViewSize.width, textViewSize.height);
}

#pragma mark - helper methods

- (void)initializeContentWithReferencePostAuthor:(NSString *)referencePostAuthor
                               referencePostTime:(NSString *)referencePostTime
                           referencePostBodyText:(NSString *)referencePostBodyText
                                    postBodyText:(NSString *)postBodyText
{
  [_referencedPostView initializeContentWithAuthor:referencePostAuthor
                                              time:referencePostTime
                                    referencedPost:referencePostBodyText];
  
  _textView.text = postBodyText;
}

+ (CGFloat)postBodyHeightWithReferencePostAuthor:(NSString *)referencePostAuthor
                               referencePostTime:(NSString *)referencePostTime
                           referencePostBodyText:(NSString *)referencePostBodyText
                                    postBodyText:(NSString *)postBodyText
{
  JCBUReferencedPostView *referencedPostView = nil;
  if (referencePostAuthor) {
    referencedPostView = [[JCBUReferencedPostView alloc] initWithAuthor:referencePostAuthor
                                                                    time:referencePostTime
                                                          referencedPost:referencePostBodyText];
  }
  CGFloat height = 0;
  
  if (referencePostAuthor) {
    CGFloat referencedViewHeight = [JCBUReferencedPostView desiredHeightWithReferencePostAuthor:referencePostAuthor
                                                                              referencePostTime:referencePostTime
                                                                          referencePostBodyText:referencePostBodyText];
    height += referencedViewHeight;
  }
  
  UITextView *textView = [[UITextView alloc] init];
  textView.font = [UIFont systemFontOfSize:14];
  textView.text = postBodyText;
  textView.textAlignment = NSTextAlignmentLeft;
  textView.scrollEnabled = NO;
  
  CGSize size = [UIScreen mainScreen].bounds.size;
  CGSize textViewSize = [textView sizeThatFits:CGSizeMake(size.width - kPostTextBodyEdgePadding * 2, size.height)];
  
  height += textViewSize.height;
  
  return height;
}
   
@end
