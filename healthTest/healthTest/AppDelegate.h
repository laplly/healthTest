//
//  AppDelegate.h
//  healthTest
//
//  Created by admin on 3/17/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "HTipsViewController.h"
//#import "TipsViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, WXApiDelegate, sendMsgToWeChatViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *rootPath;
@property (strong, nonatomic) NSMutableArray *testData;
@property (strong, nonatomic) NSMutableArray *myTest;
@end
