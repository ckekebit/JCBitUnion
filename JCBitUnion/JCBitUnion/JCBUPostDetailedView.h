//
//  JCBUPostDetailedView.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 10/12/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCBUPostNavigationView;

@interface JCBUPostDetailedView : UIView

@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic) JCBUPostNavigationView *postNavigationView;

@end
