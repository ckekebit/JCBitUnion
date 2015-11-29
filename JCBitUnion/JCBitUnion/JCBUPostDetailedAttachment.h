//
//  JCBUPostDetailedAttachment.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/29/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCBUPostDetailedAttachment : UIView

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIImageView *attachmentView;

- (instancetype)initWithImageUrl:(NSString *)imageUrl;

@end
