//
//  XSYLoveBeenViewMinePageDetailController.m
//  LoveBeen
//
//  Created by xin on 2017/3/8.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenViewMinePageDetailController.h"
#import "HQCommonViewController.h"
#import "HQCommonGroup.h"
#import "HQCommonItem.h"
#import "HQCommonCell.h"
#import "HQCommonItemArrowItem.h"
#import "HQCommonItemLabelItem.h"
#import "XSYLoveBeenMinePageHeaderView.h"

@interface XSYLoveBeenViewMinePageDetailController ()

@end

@implementation XSYLoveBeenViewMinePageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableHeaderView];
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setTableHeaderView{
    self.tableView.tableHeaderView = [[XSYLoveBeenMinePageHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, ScreenHeight * 0.15)];
}

- (void)setupGroup0
{
    // 1.创建组
    HQCommonGroup *group = [HQCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HQCommonItemArrowItem *address = [HQCommonItemArrowItem itemWithTitle:@"我的收货地址" icon:@"v2_my_address_icon"];
    
    HQCommonItemArrowItem *shop = [HQCommonItemArrowItem itemWithTitle:@"我的店铺" icon:@"icon_mystore"];
    
    group.items = @[address, shop];
}



- (void)setupGroup1
{
    // 1.创建组
    HQCommonGroup *group = [HQCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HQCommonItemArrowItem *share = [HQCommonItemArrowItem itemWithTitle:@"把爱鲜蜂分享给朋友" icon:@"v2_my_share_icon"];
    
    group.items = @[share];
}

- (void)setupGroup2{
    // 1.创建组
    HQCommonGroup *group = [HQCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    HQCommonItemArrowItem *help = [HQCommonItemArrowItem itemWithTitle:@"客服帮助" icon:@"v2_my_serviceonline_icon"];
    
    HQCommonItemArrowItem *feedback = [HQCommonItemArrowItem itemWithTitle:@"意见反馈" icon:@"v2_my_feedback_icon"];
    
    group.items = @[help, feedback];
}
@end
