//
//  JCBULogInView.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/12/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JCBULogInView : UIView

@property (nonatomic) UILabel *userNameLabel;
@property (nonatomic) UITextField *userNameTextField;
@property (nonatomic) UILabel *passwordLabel;
@property (nonatomic) UITextField *passwordTextField;
@property (nonatomic) UIButton *logInButton;
@property (nonatomic) UIActivityIndicatorView *loadingIndicator;

@property (nonatomic) UIView *gView;

@property (nonatomic, weak) id<UITextFieldDelegate> delegate;

@end
