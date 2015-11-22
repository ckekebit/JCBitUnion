//
//  JCBUFirstPagePostCell.h
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 10/4/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JCBUFirstPagePostCellDelegate;

@interface JCBUFirstPagePostCell : UITableViewCell

@property (nonatomic) UILabel *subjectLabel;
@property (nonatomic) UILabel *forumLabel;
@property (nonatomic) UILabel *authorLabel;
@property (nonatomic, weak) id<JCBUFirstPagePostCellDelegate> delegate;
@property (nonatomic) NSUInteger cellIndex;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

@protocol JCBUFirstPagePostCellDelegate <NSObject>

- (void)didTapAuthor:(NSString *)postAuthor;
- (void)didTapSubject:(NSUInteger)cellIndex;
- (void)didTapForum:(NSUInteger)cellIndex;

@end
