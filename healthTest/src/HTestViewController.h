//
//  TestViewController.h
//  healthTest
//
//  Created by admin on 3/18/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSuperViewController.h"
#import "ASIHTTPRequest.h"
@interface HTestViewController : HSuperViewController <UITableViewDataSource, UITableViewDelegate, ASIHTTPRequestDelegate>

@property (nonatomic) NSInteger quesID;
@property (strong, nonatomic) NSString *titleStr;


@end
