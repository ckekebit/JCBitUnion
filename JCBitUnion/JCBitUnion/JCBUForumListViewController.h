//
//  JCBUForumListViewController.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/14/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCBUUser;

@interface JCBUForumListViewController : UITableViewController

- (instancetype)initWithUserInfo:(JCBUUser *)userInfo forumList:(NSArray *)forumList forumGroupSubject:(NSString *)forumGroupSubject;

@property (nonatomic) NSArray *forumList;

@end
