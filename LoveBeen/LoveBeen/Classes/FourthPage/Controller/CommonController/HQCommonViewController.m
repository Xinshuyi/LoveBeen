//
//  HQCommonViewController.m
//  ListenToThis
//
//  Created by zhq on 15/10/4.
//  Copyright © 2015年 zhq. All rights reserved.
//

#import "HQCommonViewController.h"
#import "HQCommonGroup.h"
#import "HQCommonItem.h"
#import "HQCommonCell.h"
#import "HQCommonItemArrowItem.h"
#import "HQCommonItemSwitchItem.h"
#import "CZAdditions.h"

@interface HQCommonViewController ()
@property (nonatomic, strong) NSMutableArray *groups;
@end

@implementation HQCommonViewController

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}

/** 屏蔽tableView的样式 */
- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置tableView属性
    self.tableView.backgroundColor = [UIColor cz_colorWithRed:239 green:239 blue:239];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HQCommonGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HQCommonCell *cell = [HQCommonCell cellWithTableView:tableView];
    HQCommonGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取出这行对应的item模型
    HQCommonGroup *group = self.groups[indexPath.section];
    HQCommonItem *item = group.items[indexPath.row];
    
    // 2.判断有无需要跳转的控制器
    if (item.destVcClass) {
        UIViewController *destVc = [[item.destVcClass alloc] init];
        destVc.title = item.title;
        [self.navigationController pushViewController:destVc animated:YES];
    }
    
    // 3.判断有无想执行的操作
    if (item.operation) {
        item.operation();
    }
}

//脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

@end
