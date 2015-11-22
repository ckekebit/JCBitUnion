//
//  JCBUReferencedPostView.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 10/18/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCBUReferencedPostView : UIView

- (instancetype)initWithAuthor:(NSString *)author
                          time:(NSString *)timestamp
                referencedPost:(NSString *)referencedPost;

- (void)initializeContentWithAuthor:(NSString *)author
                               time:(NSString *)timestamp
                     referencedPost:(NSString *)referencedPost;

+ (CGFloat)desiredHeightWithReferencePostAuthor:referencePostAuthor
                              referencePostTime:referencePostTime
                          referencePostBodyText:referencePostBodyText;

@end
