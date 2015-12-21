//
//  RootViewController.h
//  xunlang
//
//  Created by Lap on 14-2-21.
//  Copyright (c) 2014年 Lap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRootViewController : UITabBarController <UITabBarControllerDelegate>
@property(retain,nonatomic)UIView *tabView;
-(void)hideTabView;
-(void)showTabView;
@end
