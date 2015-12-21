//
//  QuestionCell.h
//  healthTest
//
//  Created by admin on 3/19/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQuestionCell : UITableViewCell

@property (strong, nonatomic) UIButton *optionButton;
@property (strong, nonatomic) UILabel *buttonLabel;

-(void)setButtonTitle:(NSString *)str buttonTarget:(id)target;

@end
