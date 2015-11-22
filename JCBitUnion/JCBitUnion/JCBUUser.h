//
//  JCBUUser.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/13/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCBUUser : NSObject

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *userSession;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *credit;
@property (nonatomic, copy) NSString *lastActivity;

- (instancetype)initWithUserId:(NSString *)userId
                      UserName:(NSString *)userName
                      password:(NSString *)password
                   userSession:(NSString *)userSession
                        status:(NSString *)status
                        credit:(NSString *)credit
                  lastActivity:(NSString *)lastActivity;

@end
