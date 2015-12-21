//
//  MyTestTableViewCell.m
//  healthTest
//
//  Created by admin on 3/24/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "HMyTestTableViewCell.h"

@implementation HMyTestTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(290, 22, 9.5, 16)];
        [imageView setImage:[UIImage imageNamed:@"arrow"]];
        [self.contentView addSubview:imageView];
        
        
        self.bottomLine = [[UIView alloc] init];
        [self.bottomLine setBackgroundColor:[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:0.75]];
        [self.contentView addSubview:self.bottomLine];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
