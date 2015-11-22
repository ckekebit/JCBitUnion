//
//  JCBUUserInfoView.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/28/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCBUDetailedUserInfo;

@interface JCBUUserInfoView : UIView

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIActivityIndicatorView *loadingIndicator;

- (void)setImageHeight:(CGFloat)imageHeight;

@end
