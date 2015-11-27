//
//  JCBUImageDisplayView.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/25/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCBUImageDisplayView : UIView

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIImageView *imageView;

- (instancetype)initWithImage:(UIImage *)image;

@end
