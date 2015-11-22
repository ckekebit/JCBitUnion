//
//  JCBUMainTabBarViewController.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/20/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCBUForumGroupListViewController;
@class JCBUHomepageViewController;
@class JCBUFirstPageViewController;
@class JCBUFavoritesViewController;
@class JCBUUser;

@interface JCBUMainTabBarViewController : UITabBarController

@property (nonatomic) JCBUForumGroupListViewController *forumGroupListViewController;
@property (nonatomic) JCBUHomepageViewController *homepageViewController;
@property (nonatomic) JCBUFirstPageViewController *firstpageViewController;
@property (nonatomic) JCBUFavoritesViewController *favoritesViewController;

- (instancetype)initWithUserInfo:(JCBUUser *)userInfo;

@end
