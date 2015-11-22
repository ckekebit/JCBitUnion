//
//  JCBUForumThreadView.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/14/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCBUPostNavigationView;

@interface JCBUForumThreadView : UIView

@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic) JCBUPostNavigationView *postNavigationView;

@end
