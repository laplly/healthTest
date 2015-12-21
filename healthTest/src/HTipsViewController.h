//
//  TipsViewController.h
//  healthTest
//
//  Created by admin on 3/18/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSuperViewController.h"

#import "WXApiObject.h"

@protocol sendMsgToWeChatViewDelegate <NSObject>
- (void) sendAppContent;;
@end

@interface HTipsViewController : HSuperViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate,NSObject> delegate;
@end
