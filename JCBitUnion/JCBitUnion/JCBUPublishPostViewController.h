//
//  JCBUPublishPostViewController.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/19/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCBUUser;

@interface JCBUPublishPostViewController : UIViewController

- (instancetype)initWithUserInfo:(JCBUUser *)userInfo postId:(NSString *)postId subject:(NSString *)subject;

@end
