//
//  QuestionCell.m
//  healthTest
//
//  Created by admin on 3/19/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "HQuestionCell.h"
@implementation HQuestionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        self.optionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.optionButton setFrame:CGRectMake(22.5, 5, 275, 34)];
        [self.optionButton setImage:[UIImage imageNamed:@"option"] forState:UIControlStateNormal];
        [self.optionButton setImage:[UIImage imageNamed:@"option_s"] forState:UIControlStateHighlighted];
        [self.optionButton setImage:[UIImage imageNamed:@"option_s"] forState:UIControlStateSelected];
        [self.contentView addSubview:self.optionButton];
        
        
        self.buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 275, 34)];
        [self.buttonLabel setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]];
        [self.buttonLabel setFont:[UIFont fontWithName:@"Arial" size:13]];
        [self.buttonLabel setText:@"天天酸痛"];
        [self.optionButton addSubview:self.buttonLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setButtonTitle:(NSString *)str buttonTarget:(id)target
{
    [self.optionButton setSelected:NO];
    
    if ([target respondsToSelector:@selector(selectOption:)]) {
        [self.optionButton addTarget:target action:@selector(selectOption:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.buttonLabel setText:str];
    
}


@end
