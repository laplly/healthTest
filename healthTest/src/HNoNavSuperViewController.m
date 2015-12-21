//
//  NoNavSuperViewController.m
//  healthTest
//
//  Created by admin on 3/18/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "HNoNavSuperViewController.h"
#import "UIButton+WebCache.h"
#import "SBJson.h"

@interface HNoNavSuperViewController ()

@end

@implementation HNoNavSuperViewController

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
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIView *bgView = [[UIView alloc] init];
    _BGView = bgView;
    [_BGView setBackgroundColor:[UIColor whiteColor]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // iOS 7 code
        [_BGView setFrame:CGRectMake(0, 20, SCwidth, SCHeight - 20 - 50)];
    } else {
        [_BGView setFrame:CGRectMake(0, 0, SCwidth, SCHeight - 20 - 50)];
    }
    [self.view addSubview:_BGView];
    
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

@end
