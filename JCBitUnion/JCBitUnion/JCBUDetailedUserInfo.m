//
//  JCBUDetailedUserInfo.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/28/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import "JCBUDetailedUserInfo.h"

@implementation JCBUDetailedUserInfo

- (instancetype)initWithUserId:(NSString *)userId
                        status:(NSString *)status
                      userName:(NSString *)userName
                        avatar:(NSString *)avatar
                       regDate:(NSString *)regDate
                     lastVisit:(NSString *)lastVisit
                      birthday:(NSString *)birthday
                     signature:(NSString *)signature
                       postNum:(NSString *)postNum
                     threadNum:(NSString *)threadNum
                         email:(NSString *)email
                          site:(NSString *)site
                           icq:(NSString *)icq
                          oicq:(NSString *)oicq
                         yahoo:(NSString *)yahoo
                           msn:(NSString *)msn
                        credit:(NSString *)credit
{
  if (self = [super init]) {
    _userId = userId;
    _status = status;
    _userName = userName;
    _avatar = avatar;
    _regDate = regDate;
    _lastVisit = lastVisit;
    _birthday = birthday;
    _signature = signature;
    _postNum = postNum;
    _threadNum = threadNum;
    _email = email;
    _site = site;
    _icq = icq;
    _oicq = oicq;
    _yahoo = yahoo;
    _msn = msn;
    _credit = credit;
  }
  
  return self;
}

@end
