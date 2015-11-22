//
//  JCBUForumThreadInfo.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/14/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUForumThreadInfo.h"

@implementation JCBUForumThreadInfo

- (instancetype)initWithAuthor:(NSString *)author
                      authorId:(NSString *)authorId
                      dateLine:(NSString *)dateLine
                      lastPost:(NSString *)lastPost
                    lastPoster:(NSString *)lastPoster
                       replies:(NSString *)replies
                       subject:(NSString *)subject
                           tid:(NSString *)tid
                         views:(NSString *)views
{
  if (self = [super init]) {
    _author = author;
    _authorId = authorId;
    _dateLine = dateLine;
    _lastPost = lastPost;
    _lastPoster = lastPoster;
    _replies = replies;
    _subject = subject;
    _tid = tid;
    _views = views;
  }
  
  return self;
}

@end
