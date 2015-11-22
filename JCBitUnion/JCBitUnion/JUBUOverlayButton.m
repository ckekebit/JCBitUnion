//
//  JUBUOverlayButton.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 10/4/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JUBUOverlayButton.h"

@implementation JUBUOverlayButton

- (void)setHighlighted:(BOOL)highlighted
{
  [super setHighlighted:highlighted];
  self.backgroundColor = highlighted ? [UIColor colorWithWhite:0.0 alpha:0.4] : [UIColor clearColor];
}

@end
