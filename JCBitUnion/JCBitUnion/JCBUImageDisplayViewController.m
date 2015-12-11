//
//  JCBUImageDisplayViewController.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/25/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUImageDisplayViewController.h"
#import "JCBUImageDisplayView.h"

@interface JCBUImageDisplayViewController () <UIScrollViewDelegate>

@end

@implementation JCBUImageDisplayViewController

- (instancetype)initWithImage:(UIImage *)image
{
  if (self = [super init]) {
    _imageDisplayView = [[JCBUImageDisplayView alloc] initWithImage:image];
    
    _imageDisplayView.scrollView.delegate = self;
    
    UITapGestureRecognizer *singleTapRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(didSingleTapped:)];
    singleTapRecognizer.numberOfTapsRequired = 1;
    singleTapRecognizer.numberOfTouchesRequired = 1;
    [_imageDisplayView.scrollView addGestureRecognizer:singleTapRecognizer];
    
    UITapGestureRecognizer *doubleTapRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(didDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [_imageDisplayView.scrollView addGestureRecognizer:doubleTapRecognizer];
    
    [singleTapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
  }
  
  return self;
}

- (void)loadView
{
  self.view = _imageDisplayView;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  _imageDisplayView.scrollView.minimumZoomScale = 0.5;
  
  
  CGSize imageViewSize = _imageDisplayView.imageView.bounds.size;
  CGSize screenSize = [UIScreen mainScreen].bounds.size;
  CGFloat widthScale = screenSize.width / imageViewSize.width;
  CGFloat heightScale = screenSize.height / imageViewSize.height;
  
  _imageDisplayView.scrollView.minimumZoomScale = MIN(0.5, MIN(widthScale, heightScale));
  _imageDisplayView.scrollView.maximumZoomScale = MAX(2.0, MAX(widthScale, heightScale));
  _imageDisplayView.scrollView.zoomScale = MIN(widthScale, heightScale);
  
  [self _centerScrollViewContents];
}

#pragma mark - helpers

- (void)_centerScrollViewContents
{
  CGSize boundsSize = _imageDisplayView.scrollView.bounds.size;
  CGRect contentsFrame = _imageDisplayView.imageView.frame;
  
  if (contentsFrame.size.width < boundsSize.width) {
    contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
  } else {
    contentsFrame.origin.x = 0.0f;
  }
  
  if (contentsFrame.size.height < boundsSize.height) {
    contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
  } else {
    contentsFrame.origin.y = 0.0f;
  }
  
  _imageDisplayView.imageView.frame = contentsFrame;
}

#pragma mark - Target Action

- (void)didDoubleTapped:(UIGestureRecognizer *)recognizer
{
  CGPoint pointInView = [recognizer locationInView:_imageDisplayView.imageView];
  
  CGFloat newZoomScale = _imageDisplayView.scrollView.maximumZoomScale;
  
  CGSize scrollViewSize = _imageDisplayView.scrollView.bounds.size;
  
  CGFloat w = scrollViewSize.width / newZoomScale;
  CGFloat h = scrollViewSize.height / newZoomScale;
  CGFloat x = pointInView.x - (w / 2.0f);
  CGFloat y = pointInView.y - (h / 2.0f);
  
  CGRect rectToZoomTo = CGRectMake(x, y, w, h);
  
  [_imageDisplayView.scrollView zoomToRect:rectToZoomTo animated:YES];
}

- (void)didSingleTapped:(UIGestureRecognizer *)recognizer
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  return _imageDisplayView.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
  [self _centerScrollViewContents];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  [self _centerScrollViewContents];
}

@end
