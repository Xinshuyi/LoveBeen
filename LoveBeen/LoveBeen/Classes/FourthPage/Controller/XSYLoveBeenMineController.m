//
//  XSYLoveBeenMineController.m
//  LoveBeen
//
//  Created by xin on 2017/2/18.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenMineController.h"
#import "XSYLoveBeenShopingCarNavigationController.h"
#import "XSYLoveBeenShopCarController.h"

@interface XSYLoveBeenMineController ()

@end

@implementation XSYLoveBeenMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addNotification];
}

- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modalShoppingViewController) name:kShoppingCarControllerModal object:nil];
}

- (void)modalShoppingViewController{
    XSYLoveBeenShopCarController *shopController = [[XSYLoveBeenShopCarController alloc] init];
    XSYLoveBeenShopingCarNavigationController *shopCarController = [[XSYLoveBeenShopingCarNavigationController alloc] initWithRootViewController:shopController];
    [self presentViewController:shopCarController animated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kShoppingCarControllerModal object:nil];
}


@end
