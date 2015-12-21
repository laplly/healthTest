//
//  TipsCell.m
//  healthTest
//
//  Created by admin on 3/20/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "HTipsCell.h"

@implementation HTipsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 99.5, SCwidth, 0.5)];
        [self.bottomLine setBackgroundColor:[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1]];
        [self.contentView addSubview:self.bottomLine];
        
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 13, 20, 21)];
        [self.countLabel setBackgroundColor:[UIColor clearColor]];
        [self.countLabel setTextColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]];
        [self.countLabel setFont:[UIFont fontWithName:@"Arial" size:18]];
        [self.contentView addSubview:self.countLabel];
        
        
        self.contentLabel = [[FXLabel alloc] initWithFrame:CGRectMake(45, 12, 265, 45)];
        [self.contentLabel setFont:[UIFont fontWithName:@"Arial" size:15]];
        [self.contentLabel setLineSpacing:0.5];
        [self.contentLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentLabel setTextColor:[UIColor colorWithRed:70/255.0 green:67/255.0 blue:67/255.0 alpha:1]];
        [self.contentLabel setNumberOfLines:0];
        [self.contentView addSubview:self.contentLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setcount:(NSString *)count content:(NSString *)content indexPath:(NSIndexPath *)indexPath
{
    
    CGSize sizeOfLabel = [content sizeWithFont:[UIFont fontWithName:@"Arial" size:15] constrainedToSize:CGSizeMake(265, 500) lineBreakMode:0 lineSpacing:0.5 characterSpacing:0 kerningTable:nil allowOrphans:YES];
    
    NSLog(@"%f",sizeOfLabel.height);
    
    [self.bottomLine setFrame:CGRectMake(0, sizeOfLabel.height + 30 - 0.5, SCwidth, 0.5)];
    
    [self.countLabel setText:count];
    
    [self.contentLabel setText:content];
    [self.contentLabel setFrame:CGRectMake(45, 15, sizeOfLabel.width, sizeOfLabel.height)];
    
    
}

@end
