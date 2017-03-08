//
//  AppDelegate.m
//  LoveBeen
//
//  Created by xin on 2017/2/18.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "AppDelegate.h"
#import "XSYLoveBeenIntroductionController.h"
#import "XSYLoveBeenTabbarController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface AppDelegate (){
    BMKMapManager* _mapManager;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 百度地图sdk
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"okT5AowjGvGemvIKUW6FUoTs9gxGX1Yp"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    UIWindow *window = [[UIWindow alloc] init];
    self.window = window;
    window.rootViewController = [self hadUseAppBefore] ? [[XSYLoveBeenTabbarController alloc] init] : [[XSYLoveBeenIntroductionController alloc] init];
    [window makeKeyAndVisible];
    
    // 接受更换根控制器的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRootViewController:) name:kNotificationChangeRootViewController object:nil];
    return YES;
}

- (BOOL)hadUseAppBefore{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kHadUserAppBefore];
}

- (void)changeRootViewController:(NSNotification *)noti{
    self.window.rootViewController = [[NSClassFromString(noti.userInfo[CurrentRootViewController]) alloc] init];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
