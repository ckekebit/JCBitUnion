//
//  JCBUPostDetailedHeader.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 10/12/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUPostDetailedHeader.h"
#import "JUBUOverlayButton.h"

@implementation JCBUPostDetailedHeader
{
  UILabel *_nameLabel;
  UILabel *_floorNumber;
  UILabel *_timestamp;
  
  JUBUOverlayButton *_authorOverlayButton;
  JUBUOverlayButton *_imageViewOverlayButton;
}

- (instancetype)initWithImage:(UIImage *)image
                         name:(NSString *)name
                  floorNumber:(NSString *)floorNumber
                    timestamp:(NSString *)timestamp
{
  if (self = [super init]) {
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.image = image;
    [self addSubview:_imageView];
    
    _imageViewOverlayButton = [[JUBUOverlayButton alloc] init];
    _imageViewOverlayButton.backgroundColor = [UIColor clearColor];
    [_imageViewOverlayButton addTarget:self action:@selector(didTapProfilePicture) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_imageViewOverlayButton];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = name;
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = [UIColor colorWithRed:88.0/255 green:144.0/255 blue:255.0/255 alpha:1];
    [self addSubview:_nameLabel];
    
    _authorOverlayButton = [[JUBUOverlayButton alloc] init];
    _authorOverlayButton.backgroundColor = [UIColor clearColor];
    [_authorOverlayButton addTarget:self action:@selector(didTapAuthor) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_authorOverlayButton];
    
    _floorNumber = [[UILabel alloc] init];
    _floorNumber.text = floorNumber;
    _floorNumber.font = [UIFont systemFontOfSize:14];
    _floorNumber.textAlignment = NSTextAlignmentRight;
    [self addSubview:_floorNumber];
    
    _timestamp = [[UILabel alloc] init];
    _timestamp.text = timestamp;
    _timestamp.font = [UIFont systemFontOfSize:14];
    _timestamp.textAlignment = NSTextAlignmentRight;
    [self addSubview:_timestamp];
    
    self.backgroundColor = [UIColor colorWithRed:235.0/255 green:239.0/255 blue:249.0/255 alpha:1];
  }
  
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGRect bounds = self.bounds;
  _imageView.frame = CGRectMake(5, 5, 40, 40);
  _imageViewOverlayButton.frame = _imageView.frame;
  
  _nameLabel.frame = CGRectMake(55, 0, 150, bounds.size.height);
  _authorOverlayButton.frame = _nameLabel.frame;
  
  _floorNumber.frame = CGRectMake(bounds.size.width - 120, 0, 100, bounds.size.height / 2.0);
  
  _timestamp.frame = CGRectMake(bounds.size.width - 220, 20, 200, bounds.size.height / 2.0);
}

- (void)intializeContentWithImage:(UIImage *)image
                             name:(NSString *)name
                      floorNumber:(NSString *)floorNumber
                        timestamp:(NSString *)timestamp
{
  _imageView.image = image;
  _nameLabel.text = name;
  _floorNumber.text = floorNumber;
  _timestamp.text = timestamp;
}

#pragma mark - Target action

- (void)didTapAuthor
{
  [_delegate didTapAuthor:_nameLabel.text];
}

- (void)didTapProfilePicture
{
  CGSize imageSize = _imageView.image.size;
  CGFloat deltaX = 0;
  CGFloat deltaY = 0;
  CGFloat actualImageWidth = 40;
  CGFloat actualImageHeight = 40;
  if (imageSize.height > imageSize.width) {
    actualImageWidth = 40.0 / imageSize.height * imageSize.width;
    deltaX = (40.0 - actualImageWidth) / 2;
  } else {
    actualImageHeight = 40.0 / imageSize.width * imageSize.height;
    deltaY = (40.0 - actualImageHeight) / 2;
  }
  
  CGRect imageFrame = [_imageView convertRect:_imageView.bounds toView:nil];
  CGFloat newX = imageFrame.origin.x + deltaX;
  CGFloat newY = imageFrame.origin.y + deltaY;

  CGRect newFrame = CGRectMake(newX, newY, actualImageWidth, actualImageHeight);
  [_delegate didTapProfilePicture:_imageView.image withFrame:newFrame];
}

@end
