//
//  JCBUPostDetailedHeader.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 10/12/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JCBUPostDetailedHeaderDelegate;

@interface JCBUPostDetailedHeader : UIView

@property (nonatomic) UIImageView *imageView;
@property (nonatomic, weak) id<JCBUPostDetailedHeaderDelegate> delegate;

- (instancetype)initWithImage:(UIImage *)image
                         name:(NSString *)name
                  floorNumber:(NSString *)floorNumber
                    timestamp:(NSString *)timestamp;

- (void)intializeContentWithImage:(UIImage *)image
                             name:(NSString *)name
                      floorNumber:(NSString *)floorNumber
                        timestamp:(NSString *)timestamp;

@end

@protocol JCBUPostDetailedHeaderDelegate <NSObject>

- (void)didTapAuthor:(NSString *)author;

- (void)didTapProfilePicture:(UIImage *)image withFrame:(CGRect)viewFrame;

@end
