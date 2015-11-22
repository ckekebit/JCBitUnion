//
//  JCBUPostDetailedBody.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 10/13/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCBUReferencedPostView;

@interface JCBUPostDetailedBody : UIView

- (instancetype)initWithReferencePostAuthor:(NSString *)referencePostAuthor
                          referencePostTime:(NSString *)referencePostTime
                      referencePostBodyText:(NSString *)referencePostBodyText
                               postBodyText:(NSString *)postBodyText;

- (void)initializeContentWithReferencePostAuthor:(NSString *)referencePostAuthor
                               referencePostTime:(NSString *)referencePostTime
                           referencePostBodyText:(NSString *)referencePostBodyText
                                    postBodyText:(NSString *)postBodyText;

+ (CGFloat)postBodyHeightWithReferencePostAuthor:(NSString *)referencePostAuthor
                               referencePostTime:(NSString *)referencePostTime
                           referencePostBodyText:(NSString *)referencePostBodyText
                                    postBodyText:(NSString *)postBodyText;

@property (nonatomic) JCBUReferencedPostView *referencedPostView;
@property (nonatomic) UITextView *textView;

@end
