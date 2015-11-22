//
//  JCBUForumThreadViewController.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/14/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCBUUser;

@interface JCBUForumThreadViewController : UIViewController

- (instancetype)initWithUserInfo:(JCBUUser *)userInfo forumId:(NSString *)forumId forumName:(NSString *)forumName;

@end
