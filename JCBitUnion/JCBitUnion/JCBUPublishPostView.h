//
//  JCBUPublishPostView.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/19/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCBUPublishPostView : UIView

@property (nonatomic) UILabel *subjectLabel;
@property (nonatomic) UIView *separator;
@property (nonatomic) UITextView *textView;

- (instancetype)initWithSubject:(NSString *)subject;

@end
