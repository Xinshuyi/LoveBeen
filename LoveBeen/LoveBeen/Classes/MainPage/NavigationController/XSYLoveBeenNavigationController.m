//
//  ZFBNavigationController
//  支付宝项目
//
//  Created by xin on 2016/10/24.
//  Copyright © 2016年 DogeEggEgg. All rights reserved.
//


#import "XSYLoveBeenNavigationController.h"
#import "CZAdditions.h"
#import "UIBarButtonItem+Extension.h"

@interface XSYLoveBeenNavigationController ()<UIGestureRecognizerDelegate>
@end

@implementation XSYLoveBeenNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 修改导航条背景色
    self.navigationBar.barTintColor = mainColor;
    // 设置左右item的颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
    // 取消半透明
    self.navigationBar.translucent = NO;
    // 导航栏标题颜色、字体等
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:15]};
    // 隐藏导航条的分割线
    self.navigationBar.shadowImage = [UIImage new];
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 确保因为自定义左侧返回按钮而失去的侧滑返回功能不消失
    self.interactivePopGestureRecognizer.delegate = self;
}

// 设置状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma 当navitationcontroller的根控制器推进新的控制器后都隐藏tabbaritem 重写 统一修改左侧返回图片
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        // push的时候隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        // 自定义左边的返回按钮 导入李明杰的分类
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"v2_goback" isLeft:YES];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

// 确保侧滑功能
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.childViewControllers.count > 1;
}
@end
