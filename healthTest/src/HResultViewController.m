//
//  ResultViewController.m
//  healthTest
//
//  Created by admin on 3/19/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "HResultViewController.h"
#import "HTipsViewController.h"
@interface HResultViewController ()

@end

@implementation HResultViewController

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
    
    self.titleLabel.text = @"测试结果";
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, SCwidth, 303)];
    
    switch ([[self.dataDic objectForKey:@"level_id"] integerValue]) {
        case 1:
            [img setImage:[UIImage imageNamed:@"result_1"]];
            break;
        case 2:
            [img setImage:[UIImage imageNamed:@"result_2"]];
            break;
        case 3:
            [img setImage:[UIImage imageNamed:@"result_3"]];
            break;
        case 4:
            [img setImage:[UIImage imageNamed:@"result_4"]];
            break;
            
        default:
            break;
    }
    [self.BGView addSubview:img];
    
    
    UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 202, SCwidth, 18)];
    [desLabel setFont:[UIFont fontWithName:@"Arial-boldMT" size:18]];
    [desLabel setTextAlignment:NSTextAlignmentCenter];
    [desLabel setTextColor:[UIColor whiteColor]];
    [desLabel setText:[NSString stringWithFormat:@"%@", [self.dataDic objectForKey:@"des"]]];
    
    [img addSubview:desLabel];
    
    
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton addTarget:self action:@selector(doShareButton) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setImage:[UIImage imageNamed:@"share_1"] forState:UIControlStateNormal];
    if (SCHeight >= 568) {
        [shareButton setFrame:CGRectMake(36, 303+44+36+50, 248, 48)];
    } else {
        [shareButton setFrame:CGRectMake(36, 303+44+36, 248, 48)];
    }
    [self.BGView addSubview:shareButton];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.rootVC hideTabView];
    [self.statusView setBackgroundColor:[UIColor blackColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)doShareButton
{
    //分享接口。。。。
    
    [self showTips];
}

-(void)showTips
{
    HTipsViewController *tipsVC = [[HTipsViewController alloc] init];
    tipsVC.dataArray = [self.dataDic objectForKey:@"tips"];
    [self.navigationController pushViewController:tipsVC animated:YES];
}

@end
