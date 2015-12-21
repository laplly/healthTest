//
//  AppDelegate.m
//  healthTest
//
//  Created by admin on 3/17/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "HRootViewController.h"
#import "SBJson.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [WXApi registerApp:@"wxe8e9546d98741ecd"];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"%@",self.rootPath);
    
    NSLog(@"%f", [[[UIDevice currentDevice] systemVersion] floatValue]);
    
    NSFileManager *fm=[NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:[self.rootPath stringByAppendingPathComponent:@"testData"]]) {
        NSString *str = [NSString stringWithContentsOfFile:[self.rootPath stringByAppendingPathComponent:@"testData"] encoding:NSUTF8StringEncoding error:nil];
        self.testData = [[NSMutableArray alloc] initWithArray:[str JSONValue]];
    } else {
        self.testData = [[NSMutableArray alloc] init];
    }
    
    
    if ([fm fileExistsAtPath:[self.rootPath stringByAppendingPathComponent:@"myTest"]]) {
        NSString *str = [NSString stringWithContentsOfFile:[self.rootPath stringByAppendingPathComponent:@"myTest"] encoding:NSUTF8StringEncoding error:nil];
        self.myTest = [[NSMutableArray alloc] initWithArray:[str JSONValue]];
    } else {
        self.myTest = [[NSMutableArray alloc] init];
    }
//    NSArray *array = [UIFont familyNames];
//    for  (NSString * familyname in array) {
//        NSLog(@"Family:%@" ,familyname);
//        NSArray *fontnames = [UIFont fontNamesForFamilyName:familyname];
//        for  (NSString *name in fontnames) {
//            NSLog(@"Font Name:%@" ,name);
//        }  
//    }
    
    HRootViewController *root = [[HRootViewController alloc] init];
    
    self.window.rootViewController = root;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}


-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}


-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", msg.title, msg.description, obj.extInfo, msg.thumbData.length];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle;
        if (resp.errCode == 0) {
            strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        }
//        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}


#define BUFFER_SIZE 1024 * 100
- (void) sendAppContent
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"健康测试";
    message.description = @"健康测试";
    [message setThumbImage:[UIImage imageNamed:@"testCircle"]];
    
    WXAppExtendObject *ext = [WXAppExtendObject object];
    ext.extInfo = @"<xml>13216514651465165</xml>";
    ext.url = @"http://www.qq.com";
    
    Byte* pBuffer = (Byte *)malloc(BUFFER_SIZE);
    memset(pBuffer, 0, BUFFER_SIZE);
    NSData* data = [NSData dataWithBytes:pBuffer length:BUFFER_SIZE];
    free(pBuffer);
    
    ext.fileData = data;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = 1;
    
    [WXApi sendReq:req];
}

-(void) RespAppContent
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"App消息";
    message.description = @"这种消息只有App自己才能理解，由App指定打开方式！";
    [message setThumbImage:[UIImage imageNamed:@"res2.jpg"]];
    
    WXAppExtendObject *ext = [WXAppExtendObject object];
    ext.extInfo = @"<xml>extend info</xml>";
    ext.url = @"http://weixin.qq.com";
    
    Byte* pBuffer = (Byte *)malloc(BUFFER_SIZE);
    memset(pBuffer, 0, BUFFER_SIZE);
    NSData* data = [NSData dataWithBytes:pBuffer length:BUFFER_SIZE];
    free(pBuffer);
    
    ext.fileData = data;
    
    message.mediaObject = ext;
    
    GetMessageFromWXResp* resp = [[GetMessageFromWXResp alloc] init] ;
    resp.message = message;
    resp.bText = NO;
    
    [WXApi sendResp:resp];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
