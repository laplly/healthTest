//
//  NewViewController.h
//  healthTest
//
//  Created by admin on 3/17/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "HNoNavSuperViewController.h"
@interface HNewViewController : HNoNavSuperViewController <UITableViewDataSource, UITableViewDelegate, ASIHTTPRequestDelegate, UIScrollViewDelegate>



@end
