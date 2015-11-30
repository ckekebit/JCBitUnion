//
//  JCBUPostDetailedAttachment.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/29/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JCBUPostDetailedAttachmentDelegate;

@interface JCBUPostDetailedAttachment : UIView

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIImageView *attachmentView;
@property (nonatomic, weak) id<JCBUPostDetailedAttachmentDelegate> delegate;

- (instancetype)initWithImageUrl:(NSString *)imageUrl;

@end

@protocol JCBUPostDetailedAttachmentDelegate <NSObject>

- (void)didTapAttachmentView:(UIImage *)image;

@end