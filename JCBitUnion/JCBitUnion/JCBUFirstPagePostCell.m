//
//  JCBUFirstPagePostCell.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 10/4/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUFirstPagePostCell.h"
#import "JUBUOverlayButton.h"

@implementation JCBUFirstPagePostCell
{
  JUBUOverlayButton *_subjectOverlayButton;
  JUBUOverlayButton *_forumOverlayButton;
  JUBUOverlayButton *_authorOverlayButton;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    _subjectLabel = [[UILabel alloc] init];
    _subjectLabel.numberOfLines = 2;
    _subjectLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:_subjectLabel];
    
    _subjectOverlayButton = [[JUBUOverlayButton alloc] init];
    _subjectOverlayButton.backgroundColor = [UIColor clearColor];
    [_subjectOverlayButton addTarget:self action:@selector(didTapSubject:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_subjectOverlayButton];
    
    _forumLabel = [[UILabel alloc] init];
    _forumLabel.font = [UIFont systemFontOfSize:14];
    _forumLabel.textColor = [UIColor colorWithRed:88.0/255 green:144.0/255 blue:255.0/255 alpha:1];
    [self.contentView addSubview:_forumLabel];
    
    _forumOverlayButton = [[JUBUOverlayButton alloc] init];
    _forumOverlayButton.backgroundColor = [UIColor clearColor];
    [_forumOverlayButton addTarget:self action:@selector(didTapForum:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_forumOverlayButton];

    _authorLabel = [[UILabel alloc] init];
    _authorLabel.textAlignment = NSTextAlignmentRight;
    _authorLabel.font = [UIFont systemFontOfSize:14];
    _authorLabel.textColor = [UIColor colorWithRed:88.0/255 green:144.0/255 blue:255.0/255 alpha:1];
    [self.contentView addSubview:_authorLabel];
    
    _authorOverlayButton = [[JUBUOverlayButton alloc] init];
    _authorOverlayButton.backgroundColor = [UIColor clearColor];
    [_authorOverlayButton addTarget:self action:@selector(didTapAuthor:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_authorOverlayButton];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGRect bounds = self.bounds;
  _subjectLabel.frame = CGRectMake(10, 5, bounds.size.width - 20, 42);
  _subjectOverlayButton.frame = _subjectLabel.frame;
  
  _forumLabel.frame = CGRectMake(10, bounds.size.height - 24, bounds.size.width / 2 - 10, 20);
  _forumOverlayButton.frame = _forumLabel.frame;
  
  _authorLabel.frame = CGRectMake(bounds.size.width / 2, bounds.size.height - 24, bounds.size.width / 2 - 10, 20);
  _authorOverlayButton.frame = _authorLabel.frame;
}

#pragma mark - Target Action

- (void)didTapAuthor:(id)sender
{
  [_delegate didTapAuthor:_authorLabel.text];
}

- (void)didTapSubject:(id)sender
{
  [_delegate didTapSubject:_cellIndex];
}

- (void)didTapForum:(id)sender
{
  [_delegate didTapForum:_cellIndex];
}

@end
