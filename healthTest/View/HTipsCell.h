//
//  TipsCell.h
//  healthTest
//
//  Created by admin on 3/20/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXLabel.h"
@interface HTipsCell : UITableViewCell

@property (nonatomic) UIView *bottomLine;
@property (strong, nonatomic) UILabel *countLabel;
@property (strong, nonatomic) FXLabel *contentLabel;

-(void)setcount:(NSString *)count content:(NSString *)content indexPath:(NSIndexPath *)indexPath;

@end
