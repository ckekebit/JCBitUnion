//
//  JCBULogInView.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 9/12/15.
//  Copyright (c) 2015 JC Limited. All rights reserved.
//

#import "JCBULogInView.h"

typedef NS_ENUM(NSUInteger, JCBULogInTextFieldTag) {
  JCBULogInNameField = 0,
  JCBULogInPasswordField,
};

@interface JCBULogInView () <UITextFieldDelegate>

@end

@implementation JCBULogInView
{
  CAGradientLayer *_gradientLayer;
  CAShapeLayer *_shapeLayer;
}

- (instancetype)init
{
  if (self = [super init]) {
    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.font = [UIFont systemFontOfSize:16];
    _userNameLabel.text = @"User name:";
    _userNameLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_userNameLabel];
    
    _userNameTextField = [[UITextField alloc] init];
    _userNameLabel.font = [UIFont systemFontOfSize:16];
    _userNameTextField.placeholder = @"Input User Name";
    _userNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _userNameTextField.tag = JCBULogInNameField;
    _userNameTextField.delegate = self;
    [self addSubview:_userNameTextField];
    
    _passwordLabel = [[UILabel alloc] init];
    _passwordLabel.font = [UIFont systemFontOfSize:16];
    _passwordLabel.text = @"Password:";
    _passwordLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_passwordLabel];
    
    _passwordTextField = [[UITextField alloc] init];
    _passwordTextField.font = [UIFont systemFontOfSize:16];
    _passwordTextField.placeholder = @"Input Password";
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.tag = JCBULogInPasswordField;
    _passwordTextField.delegate = self;
    [self addSubview:_passwordTextField];
    
    _logInButton = [[UIButton alloc] init];
    _logInButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_logInButton setTitle:@"Log In" forState:UIControlStateNormal];
    [_logInButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_logInButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3] forState:UIControlStateHighlighted];
    [_logInButton addTarget:nil action:@selector(didTapLogIn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_logInButton];
    
    _loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:_loadingIndicator];
    
    self.backgroundColor = [UIColor colorWithRed:110.0/255 green:183.0/255 blue:1.0 alpha:1];
    
//    _gView = [[UIView alloc] init];
//    _gView.backgroundColor = [UIColor whiteColor];
//    _gradientLayer = [CAGradientLayer layer];
//    _gradientLayer.colors = @[(id)[UIColor colorWithRed:1 green:0 blue:0 alpha:0.0f].CGColor,
//                     (id)[UIColor colorWithRed:1 green:0 blue:0 alpha:0.2f].CGColor,
//                     (id)[UIColor colorWithRed:0 green:1 blue:0 alpha:0.4f].CGColor,
//                     (id)[UIColor colorWithRed:1 green:1 blue:0 alpha:0.6f].CGColor,
//                     (id)[UIColor colorWithRed:0 green:0 blue:1 alpha:0.4f].CGColor];
//    _gradientLayer.locations = @[@0.0f, @0.2f, @0.4f, @0.6f, @0.8f];
//    
//    [_gradientLayer setStartPoint:CGPointMake(0.0, 0)];
//    [_gradientLayer setEndPoint:CGPointMake(1.0, 0)];
//    _gView.backgroundColor = [UIColor clearColor];
//    [_gView.layer addSublayer:_gradientLayer];
//    
//    
//    _shapeLayer = [CAShapeLayer layer];
//    _shapeLayer.strokeColor = [UIColor yellowColor].CGColor;
//    _shapeLayer.fillColor = nil;
//    _shapeLayer.lineDashPattern = @[@4, @2];
//    [_gView.layer addSublayer:_shapeLayer];
//    
//    [self addSubview:_gView];
//
  }
  
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGRect bounds = self.bounds;
  CGFloat yOffset = 120;
  
  _userNameLabel.frame = CGRectMake(20, yOffset, 95, 32);
  _userNameTextField.frame = CGRectMake(120, yOffset, bounds.size.width - 20 * 2 - 110, 32);
  
  yOffset += 40;
  _passwordLabel.frame = CGRectMake(20, yOffset, 95, 32);
  _passwordTextField.frame = CGRectMake(120, yOffset, bounds.size.width - 20 * 2 - 110, 32);
  
  yOffset += 50;
  _logInButton.frame = CGRectMake(20, yOffset, bounds.size.width - 40, 32);
  
  yOffset += 50;
  _loadingIndicator.frame = CGRectMake((bounds.size.width - 32) / 2.0, yOffset, 32, 32);
//  yOffset += 50;
//  _gView.frame = CGRectMake(20, yOffset, bounds.size.width - 40, bounds.size.width - 40);
//  _gradientLayer.frame = CGRectMake(0, 0, bounds.size.width - 40, bounds.size.width - 40);
  //_shapeLayer.path = [UIBezierPath bezierPathWithRect:CGRectMake(10, 10, bounds.size.width - 40 - 20, bounds.size.width - 40 - 20)].CGPath;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  if (textField.tag == JCBULogInNameField) {
    [_passwordTextField becomeFirstResponder];
  } else {
    [_delegate performSelector:@selector(didTapLogIn) withObject:nil];
  }
  
  return YES;
}

@end
