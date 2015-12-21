//
//  TestViewController.m
//  healthTest
//
//  Created by admin on 3/18/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "HTestViewController.h"
#import "HQuestionCell.h"
#import "HQuestionHeaderCell.h"
#import "HResultViewController.h"
#import "SBJson.h"
#import "AppDelegate.h"

#define PI 3.14159265358979323846


@interface HTestViewController ()
@property (strong, nonatomic) UILabel *numLabel;
@property (nonatomic) NSInteger numOfQues;
@property (weak, nonatomic) UITableView *quesTableView;
@property (nonatomic) NSInteger totalScore;
@property (strong, nonatomic) NSMutableDictionary *requestDic;
@property (strong, nonatomic) NSString *keyOfStandard;
@end

@implementation HTestViewController

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
    
    self.titleLabel.text = @"健康测试";
    
    self.numOfQues = 1;
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCwidth, 160)];
    [blueView setBackgroundColor:[UIColor colorWithRed:52/255.0 green:153/255.0 blue:220/255.0 alpha:1]];
    [self.BGView addSubview:blueView];
    
    
    UILabel *testNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 17, SCwidth, 23)];
    [testNameLabel setTextColor:[UIColor whiteColor]];
    [testNameLabel setTextAlignment:NSTextAlignmentCenter];
    [testNameLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:24]];
    [testNameLabel setText:[NSString stringWithFormat:@"%@",self.titleStr]];
    [blueView addSubview:testNameLabel];
    
//    UIImage *cirImage = [self drawACircle];
    
    UIImageView *circleView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 160-80-22, 80, 80)];
    [circleView setImage:[UIImage imageNamed:@"testCircle"]];
    [blueView addSubview:circleView];
    
    
    
    
    
    UITableView *_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44 + 160, SCwidth, self.BGView.frame.size.height - 44 - 160)];
    [_tableView setShowsVerticalScrollIndicator:NO];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.BGView addSubview:_tableView];
    self.quesTableView = _tableView;
    
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://2.jkcs.sinaapp.com/api/paper/get?paper_id=%d",self.quesID]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;
    //    [request setPostValue:@"1" forKey:@"condition.page"];
    //    [request setPostValue:@(1) forKey:@"condition.status"];
    [request setTimeOutSeconds:5];
    [request startAsynchronous];
    [request setCompletionBlock:^{
        
        self.requestDic = [[request responseData] JSONValue];
//        NSLog(@"%@",self.requestDic);
        
        self.quesTableView.delegate = self;
        self.quesTableView.dataSource = self;
        [self.quesTableView reloadData];
        
        self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        [self.numLabel setTextColor:[UIColor colorWithRed:44/255.0 green:126/255.0 blue:180/255.0 alpha:1]];
        [self.numLabel setFont:[UIFont fontWithName:@"Arial-boldMT" size:35]];
        [self.numLabel setTextAlignment:NSTextAlignmentCenter];
        [self.numLabel setText:[NSString stringWithFormat:@"%d/%d",self.numOfQues,[[self.requestDic objectForKey:@"question"] count]]];
        [circleView addSubview:self.numLabel];
        
        //        NSString *str = [[NSString alloc]initWithString:[_dataDic JSONRepresentation]];
        //        [str writeToFile:[appDelegate.rootPath stringByAppendingPathComponent:@"GList"] atomically:YES encoding:NSUTF8StringEncoding error:nil];
        //        [str release];
    }];
    
    [request setFailedBlock:^{
        
        self.quesTableView.delegate = nil;
        self.quesTableView.dataSource = nil;
    }];
}

//-(UIImage *)drawACircle
//{
//    UIGraphicsBeginImageContext(CGSizeMake(80, 80));
//    
//    CGContextRef gc = UIGraphicsGetCurrentContext();
//    
//    CGContextSetAllowsAntialiasing(gc, true);
//    CGContextSetShouldAntialias(gc, true);
//    
//    UIColor *aColor = [UIColor whiteColor];
//    CGContextSetFillColorWithColor(gc, aColor.CGColor);//填充颜色
//    CGContextSetLineWidth(gc, 3);//线的宽度
//    CGContextAddArc(gc, 40, 40, 38.5, 0, 2*PI, 0); //添加一个圆
//    
////    [[UIColor blueColor] setStroke];
//    
//    CGContextSetStrokeColorWithColor(gc, [UIColor colorWithRed:44/255.0 green:126/255.0 blue:180/255.0 alpha:1].CGColor);
//    
//    CGContextDrawPath(gc, kCGPathFillStroke);
//    
//    //从Context中获取图像，并显示在界面上
//    
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return img;
//}

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



-(void)analyse
{
    NSString *keyOfStandard;
    
    NSArray *keysArray = [[self.requestDic objectForKey:@"standard"] allKeys];
    for (NSString *key in keysArray) {
        NSDictionary *dic = [[self.requestDic objectForKey:@"standard"] objectForKey:key];
        NSInteger upScore = [[dic objectForKey:@"score_up"] integerValue];
        NSInteger downScore = [[dic objectForKey:@"score_down"] integerValue];
        NSLog(@"%d %d",upScore, downScore);
        if (self.totalScore >= downScore && self.totalScore <= upScore) {
            keyOfStandard = [key copy];
            break;
        }
    }
    
    NSMutableDictionary *myTestDic = [[NSMutableDictionary alloc] initWithCapacity:2];
    [myTestDic setValue:[NSString stringWithFormat:@"%@",[self.requestDic objectForKey:@"id"]] forKey:@"id"];
    [myTestDic setValue:[[self.requestDic objectForKey:@"standard"] objectForKey:keyOfStandard] forKey:@"result"];
    
    BOOL isExist = NO;
    for (int i = 0; i<[self.appDelegate.myTest count]; i++) {
        if ([[NSString stringWithFormat:@"%@",[self.requestDic objectForKey:@"id"]] isEqualToString:[NSString stringWithFormat:@"%@",[[self.appDelegate.myTest objectAtIndex:i] objectForKey:@"id"]]]) {
            [self.appDelegate.myTest replaceObjectAtIndex:i withObject:myTestDic];
            isExist = YES;
            break;
        }
    }
    if (!isExist) {
        [self.appDelegate.myTest addObject:myTestDic];
    }
    
    
    NSString *str = [[NSString alloc]initWithString:[self.appDelegate.myTest JSONRepresentation]];
    [str writeToFile:[self.appDelegate.rootPath stringByAppendingPathComponent:@"myTest"] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"self.appDelegate.myTest:    %@",self.appDelegate.myTest);
    
//    NSLog(@"%@",keyOfStandard);
    
    UIView *analyseView = [[UIView alloc] initWithFrame:self.quesTableView.frame];
    [analyseView setBackgroundColor:[UIColor whiteColor]];
    [self.BGView addSubview:analyseView];
    
    UILabel *analyseLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 71, SCwidth, 13)];
    [analyseLabel setText:@"正在分析，请稍后..."];
    [analyseLabel setTextColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1]];
    [analyseLabel setFont:[UIFont fontWithName:@"Arial-boldMT" size:14]];
    [analyseLabel setTextAlignment:NSTextAlignmentCenter];
    [analyseView addSubview:analyseLabel];
    
    UIView *progressBGView = [[UIView alloc] initWithFrame:CGRectMake((SCwidth - 190)/2, 100, 190, 8)];
    [progressBGView setBackgroundColor:[UIColor colorWithRed:222/255.0 green:243/255.0 blue:249/255.0 alpha:1]];
    [analyseView addSubview:progressBGView];
    
    UIView *progressView = [[UIView alloc] initWithFrame:CGRectMake((SCwidth - 190)/2, 100, 0, 8)];
    [progressView setBackgroundColor:[UIColor colorWithRed:88/255.0 green:213/255.0 blue:166/255.0 alpha:1]];
    [analyseView addSubview:progressView];
    
    [UIView animateWithDuration:3 animations:^{
        [progressView setFrame:CGRectMake((SCwidth - 190)/2, 100, 190, 8)];
    } completion:^(BOOL finished) {
        HResultViewController *resultVC = [[HResultViewController alloc] init];
        resultVC.dataDic = [[self.requestDic objectForKey:@"standard"] objectForKey:keyOfStandard];
        [self.navigationController pushViewController:resultVC animated:YES];
    }];
}


#pragma -mark
#pragma -mark  UITabelViewDelegate



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[[self.requestDic objectForKey:@"question"] objectAtIndex:self.numOfQues - 1] objectForKey:@"options"] count] + 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSString *str = [NSString stringWithFormat:@"%@",[[[self.requestDic objectForKey:@"question"] objectAtIndex:self.numOfQues - 1] objectForKey:@"content"]];
        
        CGSize size = [str sizeWithFont:[UIFont fontWithName:@"Arial-boldMT" size:20] constrainedToSize:CGSizeMake(SCwidth - 70, 500) lineBreakMode:0];
        
        return size.height + 40;
    }
    
    return 44;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSString *identifier = @"Questheader";
        HQuestionHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[HQuestionHeaderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        [cell setQuestion:[NSString stringWithFormat:@"%@",[[[self.requestDic objectForKey:@"question"] objectAtIndex:self.numOfQues - 1] objectForKey:@"content"]]];
        
        return cell;
    }
    else {
        NSString *identifier = @"Quest";
        HQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[HQuestionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
////        [cell.questionLabel setTextColor:[UIColor colorWithRed:82/255.0 green:82/255.0 blue:82/255.0 alpha:1]];
//        [cell.questionLabel setText:[NSString stringWithFormat:@"%@",[[[[[self.requestDic objectForKey:@"question"] objectAtIndex:self.numOfQues - 1] objectForKey:@"options"] objectAtIndex:indexPath.row - 1] objectForKey:@"content"]]];
        
        NSString *buttonStr =[NSString stringWithFormat:@"%@、%@",[[[[[self.requestDic objectForKey:@"question"] objectAtIndex:self.numOfQues - 1] objectForKey:@"options"] objectAtIndex:indexPath.row - 1] objectForKey:@"sequence_name"], [[[[[self.requestDic objectForKey:@"question"] objectAtIndex:self.numOfQues - 1] objectForKey:@"options"] objectAtIndex:indexPath.row - 1] objectForKey:@"content"]];
        
        [cell setButtonTitle:buttonStr buttonTarget:self];
        
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    return;
}


-(void)selectOption:(UIButton *)button
{
    button.selected = YES;
    HQuestionCell *cell = (HQuestionCell *)[[[button superview] superview] superview];
    [self updateUI:[self.quesTableView indexPathForCell:cell]];
}


-(void)updateUI:(NSIndexPath *)indexPath
{
    if (self.numOfQues > [[self.requestDic objectForKey:@"question"] count]) {
//        ResultViewController *resultVC = [[ResultViewController alloc] init];
//        resultVC.totalScore = self.totalScore;
//        [self.navigationController pushViewController:resultVC animated:YES];
        return;
    }
    
    //数据
    self.totalScore = self.totalScore + [[[[[[self.requestDic objectForKey:@"question"] objectAtIndex:self.numOfQues - 1] objectForKey:@"options"] objectAtIndex:indexPath.row - 1] objectForKey:@"scores"] integerValue];
    
//    NSLog(@"%d",self.totalScore);
    
    //视图
    
    UIControl *control = [[UIControl alloc] initWithFrame:self.quesTableView.frame];
    [self.BGView addSubview:control];
    
    HQuestionCell *cell = (HQuestionCell *)[self.quesTableView cellForRowAtIndexPath:indexPath];
    if (self.numOfQues == [[self.requestDic objectForKey:@"question"] count]) {
        [control removeFromSuperview];
        
        [self analyse];
        
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.quesTableView setFrame:CGRectMake(-SCwidth, self.quesTableView.frame.origin.y, self.quesTableView.frame.size.width, self.quesTableView.frame.size.height)];
        [self.quesTableView setAlpha:0];
    } completion:^(BOOL finished) {
        self.numOfQues = self.numOfQues + 1;
        [self.numLabel setText:[NSString stringWithFormat:@"%d/%d",self.numOfQues,[[self.requestDic objectForKey:@"question"] count]]];
        [self.quesTableView reloadData];
        [self.quesTableView setFrame:CGRectMake(SCwidth, self.quesTableView.frame.origin.y, self.quesTableView.frame.size.width, self.quesTableView.frame.size.height)];
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.quesTableView setFrame:CGRectMake(0, self.quesTableView.frame.origin.y, self.quesTableView.frame.size.width, self.quesTableView.frame.size.height)];
            [self.quesTableView setAlpha:1];
        } completion:^(BOOL finished) {
            [control removeFromSuperview];
        }];
    }];
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
