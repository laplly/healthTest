//
//  SuperViewController.m
//  healthTest
//
//  Created by admin on 3/17/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "HSuperViewController.h"
#import "UIButton+WebCache.h"
#import "SBJson.h"
#import "AppDelegate.h"


@interface HSuperViewController ()

@end

@implementation HSuperViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    
    self.rootVC = (HRootViewController *)self.tabBarController;
    
    self.appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCwidth, 20)];
        [self.view addSubview:statusView];
        self.statusView = statusView;
    }
    
    
    UIView *bgView = [[UIView alloc] init];
    _BGView = bgView;
    [_BGView setBackgroundColor:[UIColor whiteColor]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // iOS 7 code
        [_BGView setFrame:CGRectMake(0, 20, SCwidth, SCHeight - 20)];
    } else {
        [_BGView setFrame:CGRectMake(0, 0, SCwidth, SCHeight - 20)];
    }
    [self.view addSubview:_BGView];
    
    UIView *titleBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCwidth, 44)];
    [titleBGView setBackgroundColor:[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1]];
    [_BGView addSubview:titleBGView];
    _titleBG = titleBGView;
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, SCwidth, 0.5)];
    [lineView1 setBackgroundColor:[UIColor colorWithRed:170/255.0 green:170/255.0  blue:170/255.0  alpha:1]];
    [_BGView addSubview:lineView1];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((320-140)/2, 0, 140, 43.5)];
    [titleLabel setTextColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]];
    [titleLabel setFont:[UIFont fontWithName:@"Arial-boldMT" size:17]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_BGView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    //    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [addButton addTarget:self action:@selector(doAdd) forControlEvents:UIControlEventTouchUpInside];
    //    [addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    //    [addButton setFrame:CGRectMake(10, 10, 23, 23)];
    //    [titleBGView addSubview:addButton];
    
    //    updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [self addAnimations];
    //    [updateButton addTarget:self action:@selector(doUpdate:) forControlEvents:UIControlEventTouchUpInside];
    //    [updateButton setImage:[UIImage imageNamed:@"reflush2"] forState:UIControlStateNormal];
    //    [updateButton setFrame:CGRectMake(280, 7, 30, 30)];
    //    [titleBGView addSubview:updateButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
