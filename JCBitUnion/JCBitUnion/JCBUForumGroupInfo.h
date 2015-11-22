//
//  JCBUForumGroupInfo.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/14/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCBUForumGroupInfo : NSObject

- (instancetype)initWithForumGroupId:(NSString *)forumGroupId
                      forumGroupName:(NSString *)forumGroupName
                      forumGroupType:(NSString *)forumGroupType
                           forumList:(NSArray *)forumList;

@property (nonatomic) NSString *forumGroupId;
@property (nonatomic) NSString *forumGroupName;
@property (nonatomic) NSString *forumGroupType;
@property (nonatomic) NSArray *forumList;

@end
