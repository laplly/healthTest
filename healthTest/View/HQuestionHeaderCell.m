//
//  QuestionHeaderCell.m
//  healthTest
//
//  Created by admin on 3/19/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "HQuestionHeaderCell.h"

@implementation HQuestionHeaderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        self.questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(22.5, 25, SCwidth - 70, 65)];
        [self.questionLabel setNumberOfLines:0];
        [self.questionLabel setTextColor:[UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1]];
        [self.questionLabel setFont:[UIFont fontWithName:@"Arial-boldMT" size:20]];
        [self.contentView addSubview:self.questionLabel];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setQuestion:(NSString *)str
{
    CGSize size = [str sizeWithFont:[UIFont fontWithName:@"Arial-boldMT" size:20] constrainedToSize:CGSizeMake(SCwidth - 70, 500) lineBreakMode:0];
    
    [self.questionLabel setText:str];
    
    [self.questionLabel setFrame:CGRectMake(22.5, 20, SCwidth - 70, size.height)];
}

@end
