//
//  JCBUPostDetailCell.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 10/13/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUPostDetailCell.h"
#import "JCBUPostDetailedHeader.h"
#import "JCBUPostDetailedBody.h"
#import "JCBUPostDetailedAttachment.h"

static const CGFloat kPostSubjectHeight = 50.0;

@implementation JCBUPostDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                        image:(UIImage *)image
                         name:(NSString *)name
                  floorNumber:(NSString *)floorNumber
                    timestamp:(NSString *)timestamp
          referencePostAuthor:(NSString *)referencePostAuthor
            referencePostTime:(NSString *)referencePostTime
        referencePostBodyText:(NSString *)referencePostBodyText
                 postBodyText:(NSString *)postBodyText
                   attachment:(NSString *)attachment
{
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    _postDetailedHeader = [[JCBUPostDetailedHeader alloc] initWithImage:image
                                                                   name:name
                                                            floorNumber:floorNumber
                                                              timestamp:timestamp];
    [self addSubview:_postDetailedHeader];
    
    _postDetailedBody = [[JCBUPostDetailedBody alloc] initWithReferencePostAuthor:referencePostAuthor
                                                                referencePostTime:referencePostTime
                                                            referencePostBodyText:referencePostBodyText
                                                                     postBodyText:postBodyText];
    [self addSubview:_postDetailedBody];
    
    if (attachment) {
      _postDetailedAttachment = [[JCBUPostDetailedAttachment alloc] initWithImageUrl:attachment];
      [self addSubview:_postDetailedAttachment];
    }
  }
  
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  CGRect bounds = self.bounds;
  CGFloat yOffset = 0;
  CGFloat attachmentHeight = _postDetailedAttachment ? 250 : 0;
  
  _postDetailedHeader.frame = CGRectMake(0, yOffset, bounds.size.width, kPostSubjectHeight);
  yOffset += kPostSubjectHeight;
  
  _postDetailedBody.frame = CGRectMake(0, yOffset, bounds.size.width, bounds.size.height - kPostSubjectHeight - attachmentHeight);
  yOffset += bounds.size.height - kPostSubjectHeight - attachmentHeight;
  
  if (_postDetailedAttachment) {
    _postDetailedAttachment.frame = CGRectMake(0, yOffset, bounds.size.width, 250);
  }
}

- (void)initializeCellContentWithImage:(UIImage *)image
                                  name:(NSString *)name
                           floorNumber:(NSString *)floorNumber
                         timeStampText:(NSString *)dateString
                  referencedPostAuthor:(NSString *)referencePostAuthor
                     referencePostTime:(NSString *)referencePostTime
                 referencePostBodyText:(NSString *)referencePostBodyText
                          postBodyText:(NSString *)postBodyText
{
  [_postDetailedHeader intializeContentWithImage:image
                                            name:name
                                     floorNumber:floorNumber
                                       timestamp:dateString];
  
  [_postDetailedBody initializeContentWithReferencePostAuthor:referencePostAuthor
                                            referencePostTime:referencePostTime
                                        referencePostBodyText:referencePostBodyText
                                                 postBodyText:postBodyText];
}

@end
