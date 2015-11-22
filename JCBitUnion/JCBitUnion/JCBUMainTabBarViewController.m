//
//  JCBUMainTabBarViewController.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/20/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import "JCBUMainTabBarViewController.h"
#import "JCBUForumGroupListViewController.h"
#import "JCBUHomepageViewController.h"
#import "JCBUFirstPageViewController.h"
#import "JCBUFavoritesViewController.h"

@interface JCBUMainTabBarViewController ()

@end

@implementation JCBUMainTabBarViewController

- (instancetype)initWithUserInfo:(JCBUUser *)userInfo
{
  if (self = [super init]) {
    UINavigationController *firstPageNavigationController = [[UINavigationController alloc] init];
    _firstpageViewController = [[JCBUFirstPageViewController alloc] initWithUserInfo:userInfo];
    _firstpageViewController.navigationItem.title = @"首页";
    firstPageNavigationController.viewControllers = @[_firstpageViewController];
    
    UINavigationController *forumListNavigationController = [[UINavigationController alloc] init];
    _forumGroupListViewController = [[JCBUForumGroupListViewController alloc] initWithUserInfo:userInfo];
    _forumGroupListViewController.navigationItem.title = @"版面";
    forumListNavigationController.viewControllers = @[_forumGroupListViewController];
    
    UINavigationController *favoritesNavigationController = [[UINavigationController alloc] init];
    _favoritesViewController = [[JCBUFavoritesViewController alloc] init];
    _favoritesViewController.navigationItem.title = @"收藏";
    favoritesNavigationController.viewControllers = @[_favoritesViewController];
    
    UINavigationController *homepageNavigationController = [[UINavigationController alloc] init];
    _homepageViewController = [[JCBUHomepageViewController alloc] initWithLoggedInUser:userInfo];
    _homepageViewController.navigationItem.title = @"家页";
    homepageNavigationController.viewControllers = @[_homepageViewController];
    
    self.viewControllers = @[firstPageNavigationController, forumListNavigationController, favoritesNavigationController, homepageNavigationController];
  }
  
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
