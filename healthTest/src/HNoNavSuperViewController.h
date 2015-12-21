//
//  NoNavSuperViewController.h
//  healthTest
//
//  Created by admin on 3/18/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "HRootViewController.h"
@interface HNoNavSuperViewController : UIViewController
@property (weak, nonatomic) AppDelegate *appDelegate;
@property (weak, nonatomic) UIView *BGView;
@property (weak, nonatomic) UIView *statusView;
@property (weak, nonatomic) HRootViewController *rootVC;
@end
