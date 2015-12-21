//
//  HotTestCell.m
//  healthTest
//
//  Created by admin on 3/18/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "HHotTestCell.h"

@implementation HHotTestCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.rankLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 0, 100, 64)];
        [self.rankLabel setFont:[UIFont fontWithName:@"Arial-ItalicMT" size:30]];
        [self.rankLabel setText:@"1"];
        [self.rankLabel setTextColor:[UIColor colorWithRed:52/255.0 green:152/255.0 blue:219/255.0 alpha:1]];
        [self.contentView addSubview:self.rankLabel];
        
        
        self.PGImageView = [[UIImageView alloc] initWithFrame:CGRectMake(126/2, 24/2, 40, 40)];
        self.PGImageView.layer.borderWidth = 0.5;
        self.PGImageView.layer.borderColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1].CGColor;
        [self.contentView addSubview:self.PGImageView];
        
        
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(122, 15, SCwidth - 96.5, 18)];
        [self.titleLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1]];
        [self.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:14]];
        [self.contentView addSubview:self.titleLabel];
        
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(124, 40, SCwidth - 96.5, 9)];
        [self.countLabel setTextColor:[UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:1]];
        [self.countLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
        [self.contentView addSubview:self.countLabel];
        
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 63.5, SCwidth, 0.5)];
        [bottomLine setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1]];
        [self.contentView addSubview:bottomLine];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
