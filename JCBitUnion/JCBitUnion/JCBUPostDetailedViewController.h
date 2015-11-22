//
//  JCBUPostDetailedViewController.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 10/12/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCBUUser;

@interface JCBUPostDetailedViewController : UIViewController

- (instancetype)initWithUserInfo:(JCBUUser *)userInfo postId:(NSString *)postId postSubject:(NSString *)postSubject forumSubject:(NSString *)forumSubject;

@end
