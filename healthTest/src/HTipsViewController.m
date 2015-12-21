//
//  TipsViewController.m
//  healthTest
//
//  Created by admin on 3/18/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "HTipsViewController.h"
#import "HTipsCell.h"
#import "FXLabel.h"


@interface TipsShareCell : UITableViewCell
@property (nonatomic, strong) UIButton *shareButtom;
@end


@implementation TipsShareCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        self.shareButtom = [UIButton buttonWithType:UIButtonTypeCustom];
        self.shareButtom.layer.borderWidth = 1;
        self.shareButtom.layer.borderColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1].CGColor;
        self.shareButtom.layer.cornerRadius = 3;
        [self.shareButtom setImage:[UIImage imageNamed:@"tips_pic2"] forState:UIControlStateNormal];
        [self.shareButtom setFrame:CGRectMake(40, 2, 241, 36)];
        [self.contentView addSubview:self.shareButtom];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end






@interface HTipsViewController ()

@end

@implementation HTipsViewController

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
    
    self.delegate = self.appDelegate;
    
    self.titleLabel.text = @"健康小贴士";
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeButton addTarget:self action:@selector(doHome) forControlEvents:UIControlEventTouchUpInside];
    [homeButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [homeButton setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    [homeButton setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 55)];
    [homeButton setFrame:CGRectMake(0, 0, 100, 43)];
    
    [self.titleBG addSubview:homeButton];
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCwidth, 160)];
    [blueView setBackgroundColor:[UIColor colorWithRed:52/255.0 green:153/255.0 blue:220/255.0 alpha:1]];
    [self.BGView addSubview:blueView];
    
    UIImageView *tipsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(115.5, 20, 89, 89)];
    [tipsImageView setImage:[UIImage imageNamed:@"tips_pic"]];
    [blueView addSubview:tipsImageView];
    
    
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 99, SCwidth, 24)];
    [tipsLabel setText:@"健康忠告"];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowBlurRadius:0.1];
    [shadow setShadowColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [shadow setShadowOffset:CGSizeMake(0, 1)];
    
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:tipsLabel.text attributes:@{NSShadowAttributeName: shadow, NSFontAttributeName: [UIFont fontWithName:@"Arial-BoldMT" size:24], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    [tipsLabel setAttributedText:attribute];
    
    [tipsImageView addSubview:tipsLabel];
    
    
    
    UITableView *_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 204, SCwidth, self.BGView.frame.size.height - 204)];
//    [_tableView setScrollEnabled:NO];
//    [_tableView setUserInteractionEnabled:NO];
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.BGView addSubview:_tableView];
    
    
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


-(void)doHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (void)sendAppContent
{
    if (_delegate)
    {
        [_delegate sendAppContent];
    }
}


#pragma -mark
#pragma -mark  UITabelViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count] + 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.dataArray count]) {
        return 60;
    }
    
    NSString *labelStr = [self.dataArray objectAtIndex:indexPath.row];
    CGSize sizeOfLabel = [labelStr sizeWithFont:[UIFont fontWithName:@"Arial" size:15] constrainedToSize:CGSizeMake(265, 500) lineBreakMode:0 lineSpacing:0.5 characterSpacing:0 kerningTable:nil allowOrphans:YES];
    
    NSLog(@"%f",sizeOfLabel.height);
        
    return sizeOfLabel.height + 30;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self.dataArray count]) {
        NSString *identifier = @"tipsshare";
        TipsShareCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[TipsShareCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        [cell.shareButtom addTarget:self action:@selector(sendAppContent) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    NSString *identifier = @"header";
    HTipsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HTipsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell.bottomLine removeFromSuperview];
    
    if (indexPath.row != [self.dataArray count] - 1) {
        [cell.contentView addSubview:cell.bottomLine];
    }
    
    
    [cell setcount:[NSString stringWithFormat:@"%d",indexPath.row + 1] content:[NSString stringWithFormat:@"%@",[self.dataArray objectAtIndex:indexPath.row]] indexPath:indexPath];
    
    return cell;
}

@end
