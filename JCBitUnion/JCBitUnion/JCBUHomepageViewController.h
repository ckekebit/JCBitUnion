//
//  JCBUHomepageViewController.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/20/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCBUUser;

@interface JCBUHomepageViewController : UITableViewController

- (instancetype)initWithLoggedInUser:(JCBUUser *)userInfo;

@end
