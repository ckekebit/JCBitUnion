//
//  JCBUForumThreadInfo.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/14/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCBUForumThreadInfo : NSObject

- (instancetype)initWithAuthor:(NSString *)author
                      authorId:(NSString *)authorId
                      dateLine:(NSString *)dateLine
                      lastPost:(NSString *)lastPost
                    lastPoster:(NSString *)lastPoster
                       replies:(NSString *)replies
                       subject:(NSString *)subject
                           tid:(NSString *)tid
                         views:(NSString *)views;

@property (nonatomic) NSString *author;
@property (nonatomic) NSString *authorId;
@property (nonatomic) NSString *dateLine;
@property (nonatomic) NSString *lastPost;
@property (nonatomic) NSString *lastPoster;
@property (nonatomic) NSString *replies;
@property (nonatomic) NSString *subject;
@property (nonatomic) NSString *tid;
@property (nonatomic) NSString *views;

@end
