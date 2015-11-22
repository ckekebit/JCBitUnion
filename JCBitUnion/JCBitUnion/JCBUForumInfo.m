//
//  JCBUForumInfo.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/14/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUForumInfo.h"

@implementation JCBUForumInfo

- (instancetype)initWithDescription:(NSString *)description
                                fid:(NSString *)fid
                                fup:(NSString *)fup
                               icon:(NSString *)icon
                          moderator:(NSString *)moderator
                               name:(NSString *)name
                            onlines:(NSString *)onlines
                              posts:(NSString *)posts
                            threads:(NSString *)threads
                               type:(NSString *)type
                          subForums:(NSArray *)subForums
{
  if (self = [super init]) {
    _forumDescription = description;
    _fid = fid;
    _fup = fup;
    _icon = icon;
    _moderator = moderator;
    _name = name;
    _onlines = onlines;
    _posts = posts;
    _threads = threads;
    _type = type;
    _subForums = [subForums copy];
  }
  
  return self;
}

@end
