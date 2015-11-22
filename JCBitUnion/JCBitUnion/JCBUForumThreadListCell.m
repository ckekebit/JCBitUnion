//
//  JCBUForumThreadListCell.m
//  JCBitUnion
//
//  Created by Jing (Jim) Chen on 11/14/15.
//  Copyright © 2015 JC Limited. All rights reserved.
//

#import "JCBUForumThreadListCell.h"

@implementation JCBUForumThreadListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    _subjectLabel = [[UILabel alloc] init];
    _subjectLabel.numberOfLines = 2;
    _subjectLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:_subjectLabel];
    
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.font = [UIFont systemFontOfSize:14];
    _dateLabel.textColor = [UIColor colorWithRed:111.0/255 green:111.0/255 blue:111.0/255 alpha:1];
    [self.contentView addSubview:_dateLabel];
    
    _replyNumberLabel = [[UILabel alloc] init];
    _replyNumberLabel.font = [UIFont systemFontOfSize:14];
    _replyNumberLabel.textColor = [UIColor colorWithRed:111.0/255 green:111.0/255 blue:111.0/255 alpha:1];
    [self.contentView addSubview:_replyNumberLabel];
    
    _authorLabel = [[UILabel alloc] init];
    _authorLabel.font = [UIFont systemFontOfSize:14];
    _authorLabel.textAlignment = NSTextAlignmentRight;
    _authorLabel.textColor = [UIColor colorWithRed:111.0/255 green:111.0/255 blue:111.0/255 alpha:1];
    [self.contentView addSubview:_authorLabel];
  }
  
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGRect bounds = self.bounds;
  _subjectLabel.frame = CGRectMake(10, 5, bounds.size.width - 20, 42);
  
  _dateLabel.frame = CGRectMake(10, bounds.size.height - 24, bounds.size.width / 3 - 10, 20);
  
  _replyNumberLabel.frame = CGRectMake(bounds.size.width / 3, bounds.size.height - 24, bounds.size.width / 6, 20);

  _authorLabel.frame = CGRectMake(bounds.size.width /2, bounds.size.height - 24, bounds.size.width / 2 - 10, 20);
}

@end
