//
//  JCBUForumInfo.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/14/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCBUForumInfo : NSObject

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
                          subForums:(NSArray *)subForums;

@property (nonatomic) NSString *forumDescription;
@property (nonatomic) NSString *fid;
@property (nonatomic) NSString *fup;
@property (nonatomic) NSString *icon;
@property (nonatomic) NSString *moderator;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *onlines;
@property (nonatomic) NSString *posts;
@property (nonatomic) NSString *threads;
@property (nonatomic) NSString *type;
@property (nonatomic) NSArray *subForums;

@end
