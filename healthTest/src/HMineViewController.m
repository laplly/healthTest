//
//  MineViewController.m
//  healthTest
//
//  Created by admin on 3/21/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "HMineViewController.h"
#import "HMyTestTableViewCell.h"
#import "HTipsViewController.h"
#import "AppDelegate.h"

@interface HMineViewController ()
@property (strong, nonatomic) UITableView *myTestTabelView;
@property (strong, nonatomic) NSMutableArray *sectionArray;
@property (strong, nonatomic) UIView *emptyView;

@end

@implementation HMineViewController

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
    
    self.titleLabel.text = @"赚钱建议";
    
    self.sectionArray = [[NSMutableArray alloc] init];
    
    [self.BGView setBackgroundColor:[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1]];
    
    self.myTestTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, SCwidth, self.BGView.frame.size.height - 44 - 50) style:UITableViewStyleGrouped];
    [self.myTestTabelView setBackgroundColor:[UIColor clearColor]];
    [self.myTestTabelView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.BGView addSubview:self.myTestTabelView];
    
    self.emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCwidth, 100)];
    [self.emptyView setCenter:CGPointMake(SCwidth/2, SCHeight/2 - 10)];
    
    UIImageView *heartView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 23, 23)];
    [heartView setImage:[UIImage imageNamed:@"smallHeart"]];
    [self.emptyView addSubview:heartView];
    
    UILabel *emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 300, 20)];
    [emptyLabel setText:@"先去做个测试 ，再回来查看建议~"];
    [emptyLabel setTextColor:[UIColor colorWithRed:161/255.0 green:153/255.0 blue:146/255.0 alpha:1]];
    [self.emptyView addSubview:emptyLabel];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.emptyView removeFromSuperview];
    if ([self.appDelegate.myTest count] <= 0) {
        [self.BGView addSubview:self.emptyView];
    }
    
    [self.rootVC showTabView];
    [self.statusView setBackgroundColor:[UIColor blackColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.sectionArray removeAllObjects];
    
    for (int i = 0; i < 4; i++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [self.sectionArray addObject:array];
    }
    
    for (int i = 0; i < [self.appDelegate.myTest count]; i++) {
        switch ([[[[self.appDelegate.myTest objectAtIndex:i] objectForKey:@"result"] objectForKey:@"level_id"] intValue]) {
            case 1:
                [[self.sectionArray objectAtIndex:0] addObject:[self.appDelegate.myTest objectAtIndex:i]];
                break;
            case 2:
                [[self.sectionArray objectAtIndex:1] addObject:[self.appDelegate.myTest objectAtIndex:i]];
                break;
            case 3:
                [[self.sectionArray objectAtIndex:2] addObject:[self.appDelegate.myTest objectAtIndex:i]];
                break;
            case 4:
                [[self.sectionArray objectAtIndex:3] addObject:[self.appDelegate.myTest objectAtIndex:i]];
                break;
                
            default:
                break;
        }
    }
    
    for (int i = 3 ; i >= 0; i--) {
        if ([[self.sectionArray objectAtIndex:i] count] == 0) {
            [self.sectionArray removeObjectAtIndex:i];
        }
    }
    
    self.myTestTabelView.delegate = self;
    self.myTestTabelView.dataSource = self;
    
    [self.myTestTabelView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma -mark
#pragma -mark  UITabelViewDelegate


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sectionArray count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    int level = [[[[[self.sectionArray objectAtIndex:section] objectAtIndex:0] objectForKey:@"result"] objectForKey:@"level_id"] intValue];
//    NSLog(@"%@", [[[self.sectionArray objectAtIndex:section] objectAtIndex:0] objectForKey:@"result"]);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCwidth, 40)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 5, 30, 30)];
    [view addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(146, 0, 150, 40)];
    [label setFont:[UIFont fontWithName:@"Arial-boldMT" size:19]];
    [label setTextColor:[UIColor whiteColor]];
    [view addSubview:label];
    
    switch (level) {
        case 1:
        {
            [view setBackgroundColor:[UIColor colorWithRed:46/255.0 green:204/255.0 blue:113/255.0 alpha:1]];
            
            [imageView setImage:[UIImage imageNamed:@"level_1"]];
            
            [label setText:@"土豪"];
            
            break;
        }
        case 2:
        {
            [view setBackgroundColor:[UIColor colorWithRed:241/255.0 green:196/255.0 blue:15/255.0 alpha:1]];
            
            [imageView setImage:[UIImage imageNamed:@"level_2"]];
            
            [label setText:@"富翁"];
            
            break;
        }
        case 3:
        {
            [view setBackgroundColor:[UIColor colorWithRed:230/255.0 green:126/255.0 blue:34/255.0 alpha:1]];
            
            [imageView setImage:[UIImage imageNamed:@"level_3"]];
            
            [label setText:@"小康"];
            
            break;
        }
        case 4:
        {
            [view setBackgroundColor:[UIColor colorWithRed:252/255.0 green:56/255.0 blue:56/255.0 alpha:1]];
            
            [imageView setImage:[UIImage imageNamed:@"level_4"]];
            
            [label setText:@"贫民"];
            
            break;
        }
        default:
            break;
    }
//    UIView *view = 
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"1111111  %d", [[self.sectionArray objectAtIndex:section] count]);
    return [[self.sectionArray objectAtIndex:section] count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 60;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"myTest";
    HMyTestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HMyTestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == [[self.sectionArray objectAtIndex:indexPath.section] count] - 1) {
        [cell.bottomLine setFrame:CGRectMake(0, 59, SCwidth, 1)];
    } else {
        [cell.bottomLine setFrame:CGRectMake(10, 59, SCwidth, 1)];
    }
    
    NSString *labelStr;
    
    for (int i = 0; i < [self.appDelegate.testData count]; i++) {
        if ([[NSString stringWithFormat:@"%@",[[self.appDelegate.testData objectAtIndex:i] objectForKey:@"id"]] isEqualToString:[NSString stringWithFormat:@"%@",[[[self.sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"id"]]]) {
            
            labelStr = [NSString stringWithFormat:@"%@",[[self.appDelegate.testData objectAtIndex:i] objectForKey:@"title"]];
        }
    }
    
    [cell.textLabel setTextColor:[UIColor colorWithRed:53/255.0 green:40/255.0 blue:40/255.0 alpha:1]];
    [cell.textLabel setFont:[UIFont fontWithName:@"Arial" size:16]];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", labelStr];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSLog(@"%@", [[[[self.sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"result"] objectForKey:@"tips"]);
    HTipsViewController *tipsVC = [[HTipsViewController alloc] init];
    tipsVC.dataArray = [[[[self.sectionArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"result"] objectForKey:@"tips"];
    [self.navigationController pushViewController:tipsVC animated:YES];
    
}


@end
