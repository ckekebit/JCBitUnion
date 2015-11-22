//
//  JCBUUserInfoViewController.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/28/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCBUUser;

@interface JCBUUserInfoViewController : UIViewController

- (instancetype)initWithUserInfo:(JCBUUser *)userInfo postAuthor:(NSString *)postAuthor;

@end
