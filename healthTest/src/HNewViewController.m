//
//  NewViewController.m
//  healthTest
//
//  Created by admin on 3/17/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "HNewViewController.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "HRootViewController.h"
#import "SBJson.h"
#import "HNewTestCell.h"
#import "HHeaderCell.h"
#import "HTestViewController.h"
@interface HNewViewController ()
@property(strong, nonatomic)NSMutableArray *dataArray;
@property(strong, nonatomic)UITableView *quesTableView;
@end

@implementation HNewViewController
{
    
}

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
    
    
    self.quesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCwidth, self.BGView.frame.size.height)];
    [self.quesTableView setBackgroundColor:[UIColor clearColor]];
    [self.quesTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.BGView addSubview:self.quesTableView];
    
    
}

-(void)httpRequest
{
    NSURL *url = [NSURL URLWithString:@"http://2.jkcs.sinaapp.com/api/paper/getTop"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;
    //    [request setPostValue:@"1" forKey:@"condition.page"];
    //    [request setPostValue:@(1) forKey:@"condition.status"];
    [request setTimeOutSeconds:5];
    [request startAsynchronous];
    [request setCompletionBlock:^{
        
        self.dataArray = [[request responseData] JSONValue];
//        NSLog(@"%@", self.dataArray);
        
//        NSLog(<#NSString *format, ...#>)
        
        self.quesTableView.delegate = self;
        self.quesTableView.dataSource = self;
        [self.quesTableView reloadData];
        
        //        NSString *str = [[NSString alloc]initWithString:[_dataDic JSONRepresentation]];
        //        [str writeToFile:[appDelegate.rootPath stringByAppendingPathComponent:@"GList"] atomically:YES encoding:NSUTF8StringEncoding error:nil];
        //        [str release];
        
        dispatch_async(dispatch_queue_create("testData", NULL), ^{
            for (int i = 0; i < [self.dataArray count]; i++) {
                BOOL isExists = NO;
                for (int j = 0; j < [self.appDelegate.testData count]; j++) {
//                    NSLog(@"%d",[[[self.dataArray objectAtIndex:i] objectForKey:@"id"] integerValue]);
//                    NSLog(@"%d",[[[self.appDelegate.testData objectAtIndex:j] objectForKey:@"id"] integerValue]);
                    if ([[[self.dataArray objectAtIndex:i] objectForKey:@"id"] integerValue] == [[[self.appDelegate.testData objectAtIndex:j] objectForKey:@"id"] integerValue]) {
                        isExists = YES;
                        break;
                    }
                }
                if (isExists == NO) {
                    [self.appDelegate.testData addObject:[self.dataArray objectAtIndex:i]];
                }
            }
            
            NSString *str = [[NSString alloc]initWithString:[self.appDelegate.testData JSONRepresentation]];
            [str writeToFile:[self.appDelegate.rootPath stringByAppendingPathComponent:@"testData"] atomically:YES encoding:NSUTF8StringEncoding error:nil];
        });
    }];
    
    [request setFailedBlock:^{
        
        self.quesTableView.delegate = nil;
        self.quesTableView.dataSource = nil;
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
//    [self.statusView setBackgroundColor:[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1]];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self httpRequest];
    
    [self.rootVC showTabView];
    [self.statusView setBackgroundColor:[UIColor blackColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma -mark
#pragma -mark  UITabelViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count] + 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 368/2;
    }
    
    return 100;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSString *identifier = @"header";
        HHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[HHeaderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        [cell.questionLabel setText:[NSString stringWithFormat:@"%@",@"你会赚钱吗？"]];
        
        NSShadow *shadow = [[NSShadow alloc] init];
        [shadow setShadowBlurRadius:0.1];
        [shadow setShadowColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75]];
        [shadow setShadowOffset:CGSizeMake(0, 0.5)];
        
        NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:cell.questionLabel.text attributes:@{NSShadowAttributeName: shadow, NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:24], NSForegroundColorAttributeName: [UIColor whiteColor]}];
        
        [cell.questionLabel setAttributedText:attribute];
        
        
        [cell.countLabel setText:@"超过58,423人测试"];
        
        
        
        
        return cell;
    }
    else {
        NSString *identifier = @"new";
        HNewTestCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[HNewTestCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        
        
        [cell.PGImageView setImageWithURL:[NSURL URLWithString:[[self.dataArray objectAtIndex:indexPath.row -1] objectForKey:@"logo_face"]] placeholderImage:nil options:3 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            
        }];
        
        [cell.titleLabel setText:[NSString stringWithFormat:@"%@",[[self.dataArray objectAtIndex:indexPath.row -1] objectForKey:@"title"]]];
        
        [cell.title_descLabel setText:[NSString stringWithFormat:@"%@",[[self.dataArray objectAtIndex:indexPath.row -1] objectForKey:@"title"]]];
        
        [cell.countLabel setText:[NSString stringWithFormat:@"%@ 题",[[self.dataArray objectAtIndex:indexPath.row - 1] objectForKey:@"count_question"]]];
        
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        return;
    }
    
    HTestViewController *testVC = [[HTestViewController alloc] init];
    testVC.quesID = [[[self.dataArray objectAtIndex:indexPath.row - 1] objectForKey:@"id"] integerValue];
    testVC.titleStr = [NSString stringWithFormat:@"%@",[[self.dataArray objectAtIndex:indexPath.row - 1] objectForKey:@"title"]];
    [self.navigationController pushViewController:testVC animated:YES];
}


#pragma -mark
#pragma -mark  UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}





@end
