//
//  JCBUPostDetailedAttachment.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/29/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUPostDetailedAttachment.h"
#import "JUBUOverlayButton.h"

static const CGFloat kTitleLabelHorizontalPadding = 10.0;
static const CGFloat kTitleLabelHeight = 32.0;
static const CGFloat kAttachmentDimension = 200.0;

@implementation JCBUPostDetailedAttachment
{
  JUBUOverlayButton *_imageOverlayButton;
}

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
    
    _imageOverlayButton = [[JUBUOverlayButton alloc] init];
    _imageOverlayButton.backgroundColor = [UIColor clearColor];
    [_imageOverlayButton addTarget:self action:@selector(didTapAttachmentView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_imageOverlayButton];
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
  _imageOverlayButton.frame = _attachmentView.frame;
}

#pragma mark - Target Action

- (void)didTapAttachmentView
{
  CGSize imageSize = _attachmentView.image.size;
  CGFloat deltaX = 0;
  CGFloat deltaY = 0;
  CGFloat actualImageWidth = 200;
  CGFloat actualImageHeight = 200;
  if (imageSize.height > imageSize.width) {
    actualImageWidth = 200.0 / imageSize.height * imageSize.width;
    deltaX = (200.0 - actualImageWidth) / 2;
  } else {
    actualImageHeight = 200.0 / imageSize.width * imageSize.height;
    deltaY = (200.0 - actualImageHeight) / 2;
  }
  
  CGRect imageFrame = [_attachmentView convertRect:_attachmentView.bounds toView:nil];
  CGFloat newX = imageFrame.origin.x + deltaX;
  CGFloat newY = imageFrame.origin.y + deltaY;
  
  CGRect newFrame = CGRectMake(newX, newY, actualImageWidth, actualImageHeight);
  
  [_delegate didTapAttachmentView:_attachmentView.image withFrame:newFrame];
}

@end
