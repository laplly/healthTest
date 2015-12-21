//
//  SuperViewController.h
//  healthTest
//
//  Created by admin on 3/17/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HRootViewController.h"
@class AppDelegate;
@interface HSuperViewController : UIViewController

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (weak, nonatomic) UIView *BGView;
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UIView *statusView;
@property (weak, nonatomic) HRootViewController *rootVC;
@property (weak, nonatomic) UIView *titleBG;
@end
