//
//  HeaderCell.m
//  healthTest
//
//  Created by admin on 3/18/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "HHeaderCell.h"

@implementation HHeaderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.BGImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCwidth, 368/2)];
        [self.BGImageView setImage:[UIImage imageNamed:@"header"]];
        [self.contentView addSubview:self.BGImageView];
        
        
        UIImageView *gradientView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 368/2 - 120/2, SCwidth, 120/2)];
        [gradientView setImage:[UIImage imageNamed:@"gradient.png"]];
        [self.contentView addSubview:gradientView];
        
        
        self.questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(35/2, 248/2, SCwidth-35/2, 25)];
        
        [self.contentView addSubview:self.questionLabel];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(35/2, 154, SCwidth - 35/2, 13)];
        [self.countLabel setTextColor:[UIColor whiteColor]];
        [self.countLabel setFont:[UIFont fontWithName:@"Arial" size:13]];
        [self.contentView addSubview:self.countLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
