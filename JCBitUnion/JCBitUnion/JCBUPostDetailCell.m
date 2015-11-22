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
{
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    _postDetailedHeader = [[JCBUPostDetailedHeader alloc] initWithImage:image
                                                                   name:name
                                                            floorNumber:floorNumber
                                                              timestamp:timestamp];
    _postDetailedHeader.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self addSubview:_postDetailedHeader];
    
    _postDetailedBody = [[JCBUPostDetailedBody alloc] initWithReferencePostAuthor:referencePostAuthor
                                                                referencePostTime:referencePostTime
                                                            referencePostBodyText:referencePostBodyText
                                                                     postBodyText:postBodyText];
    [self addSubview:_postDetailedBody];
  }
  
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  CGRect bounds = self.bounds;
  _postDetailedHeader.frame = CGRectMake(0, 0, bounds.size.width, kPostSubjectHeight);
  
  _postDetailedBody.frame = CGRectMake(0, kPostSubjectHeight, bounds.size.width, bounds.size.height - kPostSubjectHeight);
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
