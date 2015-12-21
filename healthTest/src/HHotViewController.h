//
//  HotViewController.h
//  healthTest
//
//  Created by admin on 3/17/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNoNavSuperViewController.h"
#import "ASIHTTPRequest.h"
@interface HHotViewController : HNoNavSuperViewController <ASIHTTPRequestDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@end
