//
//  JCBUUser.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/13/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import "JCBUUser.h"

@implementation JCBUUser

- (instancetype)init
{
  NSException* userInitException = [NSException exceptionWithName:@"JCNotDesignatedInitializerException"
                                                           reason:@"Initializer is not designated and shouldn't be called"
                                                         userInfo:nil];
  @throw userInitException;
}

- (instancetype)initWithUserId:(NSString *)userId
                      UserName:(NSString *)userName
                      password:(NSString *)password
                   userSession:(NSString *)userSession
                        status:(NSString *)status
                        credit:(NSString *)credit
                  lastActivity:(NSString *)lastActivity
{
  if (self = [super init]) {
    _userId = userId;
    _userName = userName;
    _password = password;
    _userSession = userSession;
    _status = status;
    _credit = credit;
    _lastActivity = lastActivity;
  }
  
  return self;
}

@end
