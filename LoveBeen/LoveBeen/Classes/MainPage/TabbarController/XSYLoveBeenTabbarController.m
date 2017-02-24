//
//  ZFBTabBarController.m
//  支付宝项目
//
//  Created by xin on 2016/10/24.
//  Copyright © 2016年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenTabbarController.h"
#import "XSYLoveBeenNavigationController.h"
#import "UIColor+CZAddition.h"

@interface XSYLoveBeenTabbarController ()<UITabBarControllerDelegate>

@end

@implementation XSYLoveBeenTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.tabBar item的文字颜色 // 以下这句代码只会会把所有的几个tabbarItem的selected字体颜色进行改变 // 但是nomal状态下的图片还是灰色 要是想两个一起改变可以采用方法里面被注销的两个方法

    self.tabBar.tintColor = mainColor;
    
    // 2.tabBar 条的颜色
    self.tabBar.barTintColor = [UIColor whiteColor];
 
    // 3.创建tabBar的子控制器，设置item的图片 选中图片,title同时确定了两个主控制器的标题 这里的自控制器如果是collection控制器 一定要重写- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout 
    [self creatChildNavigationControllerWithClassName:@"XSYLoveBeenFirstController" title:@"首页" image:@"v2_home" selectedImage:@"v2_home_r"];
    
    [self creatChildNavigationControllerWithClassName:@"XSYLoveBeenMarketController" title:@"闪电超市" image:@"v2_order" selectedImage:@"v2_order_r"];
    
    [self creatChildNavigationControllerWithClassName:@"XSYLoveBeenShopCarController" title:@"购物车" image:@"shopCart" selectedImage:@"shopCart_r"];
    
    [self creatChildNavigationControllerWithClassName:@"XSYLoveBeenMineController" title:@"我" image:@"v2_my" selectedImage:@"v2_my_r"];

    // 透明度为不透明，默认就是透明的，在设计环境下 有两种要求
    // 1. 要求不透明 在tableview布满屏幕的情况下，设置与上下导航栏的约束
    // 2 .要求透明 设置和view的edges相同
    self.tabBar.translucent = NO;
    
    self.delegate = self;
}

- (void)creatChildNavigationControllerWithClassName:(NSString *)classString title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    Class cls = NSClassFromString(classString);
    
    UIViewController *vc = [[cls alloc] init];
    vc.title = title;
    
    UINavigationController *controller = [[XSYLoveBeenNavigationController alloc] initWithRootViewController:vc];
    controller.tabBarItem.image =[[UIImage imageNamed: image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage =[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置tabbarItem 文字的颜色 这两个方法较好 甚至能改变三个不同tabbar的字体的两种颜色
//    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
//    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateNormal];
    //tabbar标题需要文字和图片 要是光设置图片没有文字 标题文字的位置就会留空 非常难看 如何解决
    // 使得图片下移
    //controller.tabBarItem.imageInsets = UIEdgeInsetsMake(5.0, 0, -5.0, 0);
    [self addChildViewController:controller];
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController.tabBarItem.title isEqualToString:@"购物车"]) {
        // 购物车界面发送通知给其他三个界面 准备modal
        [[NSNotificationCenter defaultCenter] postNotificationName:kShoppingCarControllerModal object:nil userInfo:nil];
        return NO;
    }
    return YES;
}

@end
