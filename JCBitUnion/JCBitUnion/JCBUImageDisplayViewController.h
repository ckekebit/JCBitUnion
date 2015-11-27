//
//  JCBUImageDisplayViewController.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/25/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCBUImageDisplayView;

@interface JCBUImageDisplayViewController : UIViewController

@property (nonatomic) JCBUImageDisplayView *imageDisplayView;

- (instancetype)initWithImage:(UIImage *)image;

@end
