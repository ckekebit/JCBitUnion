//
//  JCBUForumGroupInfo.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/14/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUForumGroupInfo.h"

@implementation JCBUForumGroupInfo

- (instancetype)initWithForumGroupId:(NSString *)forumGroupId
                      forumGroupName:(NSString *)forumGroupName
                      forumGroupType:(NSString *)forumGroupType
                           forumList:(NSArray *)forumList
{
  if (self = [super init]) {
    _forumGroupId = forumGroupId;
    _forumGroupName = forumGroupName;
    _forumGroupType = forumGroupType;
    _forumList = [forumList copy];
  }
  
  return self;
}

@end
