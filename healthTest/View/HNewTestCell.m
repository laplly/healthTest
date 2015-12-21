//
//  NewTestCell.m
//  healthTest
//
//  Created by admin on 3/17/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "HNewTestCell.h"

@implementation HNewTestCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        self.PGImageView = [[UIImageView alloc] initWithFrame:CGRectMake(35/2, 35/2, 65, 65)];
        self.PGImageView.layer.borderWidth = 0.5;
        self.PGImageView.layer.borderColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1].CGColor;
        [self.contentView addSubview:self.PGImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(96.5, 22, SCwidth - 96.5, 18)];
        [self.titleLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1]];
        [self.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:20]];
        [self.contentView addSubview:self.titleLabel];
        
        self.title_descLabel = [[UILabel alloc] initWithFrame:CGRectMake(96.5, 46, SCwidth - 96.5, 10)];
        [self.title_descLabel setTextColor:[UIColor colorWithRed:138/255.0 green:138/255.0 blue:138/255.0 alpha:1]];
        [self.title_descLabel setFont:[UIFont fontWithName:@"Arial" size:11]];
        [self.contentView addSubview:self.title_descLabel];
        
        UIView *countView = [[UIView alloc] initWithFrame:CGRectMake(96.5, 66, 36, 15)];
        [countView setBackgroundColor:[UIColor colorWithRed:123/255.0 green:203/255.0 blue:1 alpha:1]];
        [countView.layer setCornerRadius:3];
        [self.contentView addSubview:countView];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 36, 9)];
        [self.countLabel setTextColor:[UIColor whiteColor]];
        [self.countLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
        [self.countLabel setTextAlignment:NSTextAlignmentCenter];
        [countView addSubview:self.countLabel];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 99.5, SCwidth, 0.5)];
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
