//
//  RootViewController.m
//  xunlang
//
//  Created by Lap on 14-2-21.
//  Copyright (c) 2014年 Lap. All rights reserved.
//

//
//  RootViewController.m
//  O2O
//
//  Created by Lap on 13-12-12.
//  Copyright (c) 2013年 Lap. All rights reserved.
//
#import "HRootViewController.h"
#import "HNewViewController.h"
#import "HHotViewController.h"
#import "HMineViewController.h"
@interface HRootViewController ()
{
    NSInteger currentIndex;
    CGFloat adjust;
}
@end

@implementation HRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        currentIndex = 0;
    }
    return self;
}

#define NUMOFITEM 3

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    [self.tabBar removeFromSuperview];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        adjust = 0;
    } else {
        adjust = 20;
    }
    NSLog(@"%f",SCHeight);
    _tabView = [[UIView alloc]initWithFrame:CGRectMake(0, SCHeight-50-adjust, 320, 50)];
    [_tabView setClipsToBounds:YES];
    [_tabView setBackgroundColor:[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1]];
    [self.view addSubview:_tabView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCwidth, 0.5)];
    [lineView setBackgroundColor:[UIColor colorWithRed:229/255.0 green:229/255.0  blue:229/255.0  alpha:1]];
    [_tabView addSubview:lineView];
    
    for (int i = 0; i < NUMOFITEM; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(320/NUMOFITEM*i, 0.5, 320/NUMOFITEM, 49)];
//        [button setAdjustsImageWhenDisabled:NO];
//        [button setAdjustsImageWhenHighlighted:NO];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabItem%d",i+1]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabItem%d_s",i+1]] forState:UIControlStateDisabled];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabItem%d_s",i+1]] forState:UIControlStateSelected];
        [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [button setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 0)];

        
        [button setTag:10+i];
        [button addTarget:self action:@selector(setIndex:) forControlEvents:UIControlEventTouchUpInside];
        [_tabView addSubview:button];
        if (i == 0) {
            [button setSelected:YES];
            [button setUserInteractionEnabled:NO];
        }
    }
    
	// Do any additional setup after loading the view.
    HNewViewController *newVC = [[HNewViewController alloc]init];
    HHotViewController *hotVC = [[HHotViewController alloc]init];
    HMineViewController *mineVC = [[HMineViewController alloc]init];
    
    [self hidesBottomBarWhenPushed];
    UINavigationController *newNav = [[UINavigationController alloc]initWithRootViewController:newVC];
    
    
    
    UINavigationController *hotNav = [[UINavigationController alloc]initWithRootViewController:hotVC];
    
    
    UINavigationController *mineNav = [[UINavigationController alloc]initWithRootViewController:mineVC];

    
    NSArray *navArray = [NSArray arrayWithObjects:newNav, hotNav, mineNav, nil];
    
    [self setViewControllers:navArray];
    
}

-(void)hideTabView
{
    [self.tabView setFrame:CGRectMake(0, SCHeight, self.tabView.frame.size.width, self.tabView.frame.size.height)];
}

-(void)showTabView
{
    [self.tabView setFrame:CGRectMake(0, SCHeight-49, self.tabView.frame.size.width, self.tabView.frame.size.height)];
}

-(void)setIndex:(UIButton *)button
{
    UIButton *cButton = (UIButton *)[self.view viewWithTag:currentIndex + 10];
    [cButton setSelected:NO];
    [button setSelected:YES];
    [button setUserInteractionEnabled:NO];
    [cButton setUserInteractionEnabled:YES];
    currentIndex = button.tag - 10;
    [self setSelectedIndex:button.tag - 10];
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
