//
//  QuestionHeaderCell.h
//  healthTest
//
//  Created by admin on 3/19/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQuestionHeaderCell : UITableViewCell

@property (strong, nonatomic) UILabel *questionLabel;

-(void)setQuestion:(NSString *)str;
@end
