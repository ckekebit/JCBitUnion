//
//  JCBUDetailedUserInfo.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/28/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCBUDetailedUserInfo : NSObject

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *regDate;
@property (nonatomic, copy) NSString *lastVisit;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *signature;
@property (nonatomic, copy) NSString *postNum;
@property (nonatomic, copy) NSString *threadNum;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *site;
@property (nonatomic, copy) NSString *icq;
@property (nonatomic, copy) NSString *oicq;
@property (nonatomic, copy) NSString *yahoo;
@property (nonatomic, copy) NSString *msn;
@property (nonatomic, copy) NSString *credit;

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
                        credit:(NSString *)credit;

@end
