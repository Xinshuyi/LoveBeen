//
//  XSYLoveBeenFirstPageDetailController.m
//  LoveBeen
//
//  Created by xin on 2017/2/20.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenFirstPageDetailController.h"
#import "XSYLoveBeenDetailPageHeaderView.h"
#import "XSYLoveBeenDetailCell.h"

static NSString *detailPageCellID = @"detailPageCellID";

@interface XSYLoveBeenFirstPageDetailController ()
@property (nonatomic, strong) XSYLoveBeenDetailPageHeaderView *headerView;
@end

@implementation XSYLoveBeenFirstPageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self loadHeaderView];
}

- (void)setupTableView{
    [self.tableView registerClass:[XSYLoveBeenDetailCell class] forCellReuseIdentifier:detailPageCellID];
    // 自定义行高
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}
- (void)loadHeaderView{
    self.headerView = [XSYLoveBeenDetailPageHeaderView DetailPageHeaderView];
    self.headerView.bottomModel = self.bottomModel;
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSYLoveBeenDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:detailPageCellID forIndexPath:indexPath];
    
    return cell;
}

@end
