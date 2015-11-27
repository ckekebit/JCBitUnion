//
//  JCBUImageDisplayViewController.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/25/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUImageDisplayViewController.h"
#import "JCBUImageDisplayView.h"

@interface JCBUImageDisplayViewController ()

@end

@implementation JCBUImageDisplayViewController

- (instancetype)initWithImage:(UIImage *)image
{
  if (self = [super init]) {
    _imageDisplayView = [[JCBUImageDisplayView alloc] initWithImage:image];
    
    self.navigationItem.title = @"View Image";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(_didTapCancel)];
  }
  
  return self;
}

- (void)loadView
{
  self.view = _imageDisplayView;
}

- (void)viewDidLoad
{
  self.edgesForExtendedLayout = UIRectEdgeNone;
}

#pragma mark - Target Action

- (void)_didTapCancel
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
