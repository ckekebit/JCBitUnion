//
//  JCBUFirstPageViewController.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/21/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCBUUser;
@protocol JCBUFirstPagePostCellDelegate;

@interface JCBUFirstPageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithUserInfo:(JCBUUser *)userInfo;

@end
