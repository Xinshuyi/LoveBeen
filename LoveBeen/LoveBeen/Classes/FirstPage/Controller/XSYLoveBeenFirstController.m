//
//  XSYLoveBeenFirstController.m
//  LoveBeen
//
//  Created by xin on 2017/2/18.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenFirstController.h"
#import "XSYLoveBeenNetworkingTools.h"
#import "XSYLoveBeenFirstPageModel.h"
#import "XSYLoveBeenFocusModel.h"
#import "XSYLoveBeenActivityAndIconModel.h"
#import "XSYLoveBeenTableHeaderView.h"
#import <SVProgressHUD.h>
#import "XSYLoveBeenFirstPageTopCell.h"

#define BackgroundGray [UIColor colorWithRed:238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1.0]

static NSString *firstPageTopCellID = @"firstPageTopCellID";

@interface XSYLoveBeenFirstController ()
@property (nonatomic, strong) XSYLoveBeenFirstPageModel *topMainModel;
@property (nonatomic, strong) XSYLoveBeenTableHeaderView *headerView;

@end

@implementation XSYLoveBeenFirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialTableView];
    [self loadTopData];
}

- (void)initialTableView{
    self.tableView.backgroundColor = BackgroundGray;
    self.tableView.rowHeight = ScreenHeight / 5;
    // 开始的cell注册
    [self.tableView registerClass:[XSYLoveBeenFirstPageTopCell class] forCellReuseIdentifier:firstPageTopCellID];
}
- (void)setHeaderView{
    self.headerView = [[XSYLoveBeenTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, 200) andTopMainModel:self.topMainModel];
    self.tableView.tableHeaderView = self.headerView;
}
- (void)loadTopData{
    [XSYLoveBeenNetworkingTools getFirstPageDataWithSuccessBlock:^(id response) {
        self.topMainModel = response;
        [self setHeaderView];
        [self.tableView reloadData];
    } FailureBlock:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络不佳"];
    }];
}

#pragma mark - dataSource and delegate -
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"新鲜热卖";
    }
    return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.topMainModel.activities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XSYLoveBeenFirstPageTopCell *topCell = [tableView dequeueReusableCellWithIdentifier:firstPageTopCellID forIndexPath:indexPath];
    topCell.activityModel = self.topMainModel.activities[indexPath.row];
    return topCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return ScreenHeight / 13;
}

@end
