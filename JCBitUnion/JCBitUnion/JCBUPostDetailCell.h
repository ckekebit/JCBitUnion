//
//  JCBUPostDetailCell.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 10/13/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCBUPostDetailedHeader;
@class JCBUPostDetailedBody;
@class JCBUPostDetailedAttachment;

@interface JCBUPostDetailCell : UITableViewCell

@property (nonatomic) JCBUPostDetailedHeader *postDetailedHeader;
@property (nonatomic) JCBUPostDetailedBody *postDetailedBody;
@property (nonatomic) JCBUPostDetailedAttachment *postDetailedAttachment;

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
                   attachment:(NSString *)attachment;

- (void)initializeCellContentWithImage:(UIImage *)image
                                  name:(NSString *)name
                           floorNumber:(NSString *)floorNumber
                         timeStampText:(NSString *)dateString
                  referencedPostAuthor:(NSString *)referencePostAuthor
                     referencePostTime:(NSString *)referencePostTime
                 referencePostBodyText:(NSString *)referencePostBodyText
                          postBodyText:(NSString *)postBodyText;

@end
