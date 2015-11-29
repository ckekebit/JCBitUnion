//
//  JCBUPostDetailedAttachment.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/29/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUPostDetailedAttachment.h"

static const CGFloat kTitleLabelHorizontalPadding = 10.0;
static const CGFloat kTitleLabelHeight = 32.0;
static const CGFloat kAttachmentDimension = 200.0;

@implementation JCBUPostDetailedAttachment

- (instancetype)initWithImageUrl:(NSString *)imageUrl
{
  if (self = [super init]) {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.text = @"本帖包含图片附件：";
    _titleLabel.textColor = [UIColor blackColor];
    [self addSubview:_titleLabel];
    
    _attachmentView = [[UIImageView alloc] init];
    _attachmentView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_attachmentView];
  }
  
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGRect bounds = self.bounds;
  CGFloat yOffset = 5.0;
  
  _titleLabel.frame = CGRectMake(kTitleLabelHorizontalPadding, yOffset, bounds.size.width - kTitleLabelHorizontalPadding * 2, kTitleLabelHeight);
  yOffset += kTitleLabelHeight;
  
  _attachmentView.frame = CGRectMake((bounds.size.width - kAttachmentDimension) / 2.0, yOffset + 3.0, kAttachmentDimension, kAttachmentDimension);
}

@end
