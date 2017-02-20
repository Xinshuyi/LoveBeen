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
#import "XSYLoveBeenFirstPageBottomShoppingModel.h"
#import "XSYLoveBeenFirstPageTableBottomCell.h"
#import "XSYRefreshHeader.h"
#import <MJRefresh.h>
#import "XSYLoveBeenFirstPageWebViewController.h"
#import "XSYLoveBeenFirstPageDetailController.h"

static NSString *firstPageTopCellID = @"firstPageTopCellID";
static NSString *firstPageBottomCellID = @"firstPageBottomCellID";

@interface XSYLoveBeenFirstController ()<XSYLoveBeenFirstPageTableBottomCellDelegate, XSYLoveBeenTableHeaderViewDelegate>
@property (nonatomic, strong) XSYLoveBeenFirstPageModel *topMainModel;
@property (nonatomic, strong) XSYLoveBeenTableHeaderView *headerView;
@property (nonatomic, strong) NSArray<XSYLoveBeenFirstPageBottomShoppingModel *> *shoppingModelArray;
@property (nonatomic, assign) CGFloat oldContentOffsetY;
@property (nonatomic, assign) BOOL isScrollToTop;

@end

@implementation XSYLoveBeenFirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialTableView];
    [self setHeaderAndFooter];
}
- (void)setHeaderAndFooter{
    // Set header
    XSYRefreshHeader *header = [XSYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];

}
- (void)initialTableView{
    self.tableView.backgroundColor = BackgroundGray;
    // 开始的cell注册
    [self.tableView registerClass:[XSYLoveBeenFirstPageTopCell class] forCellReuseIdentifier:firstPageTopCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"XSYLoveBeenFirstPageTableBottomCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:firstPageBottomCellID];
}
- (void)setHeaderView{

    self.headerView = [[XSYLoveBeenTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, 200) andTopMainModel:self.topMainModel];
    self.tableView.tableHeaderView = self.headerView;
    self.headerView.delegate = self;
}
- (void)loadData{
    [XSYLoveBeenNetworkingTools getFirstPageDataWithSuccessBlock:^(id response) {
        self.topMainModel = response;
        [self setHeaderView];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } FailureBlock:^(NSError *error) {
        [SVProgressHUD showWithStatus:@"网络不佳"];
    }];
    [XSYLoveBeenNetworkingTools getFirstPageBottomWithSuccessBlock:^(id response) {
        self.shoppingModelArray = response;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } FailureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不佳"];
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
    if (section == 0) {
        return self.topMainModel.activities.count;
    }
    return self.shoppingModelArray.count % 2 == 0 ? self.shoppingModelArray.count / 2 : (self.shoppingModelArray.count + 1) / 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        XSYLoveBeenFirstPageTopCell *topCell = [tableView dequeueReusableCellWithIdentifier:firstPageTopCellID forIndexPath:indexPath];
        topCell.activityModel = self.topMainModel.activities[indexPath.row];
        return topCell;
    }
    XSYLoveBeenFirstPageTableBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:firstPageBottomCellID forIndexPath:indexPath];
    cell.leftModel = self.shoppingModelArray[indexPath.row * 2];
    cell.rightModel = self.shoppingModelArray[indexPath.row * 2 + 1] == nil ? nil : self.shoppingModelArray[indexPath.row * 2 + 1];
    // 下方cell注册
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return ScreenHeight / 13;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return ScreenHeight / 5;
    }
    return ScreenHeight / 2.1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || self.isScrollToTop) {
        return;
    }
    cell.transform = CGAffineTransformMakeTranslation(0, 80);
    [UIView animateWithDuration:1 animations:^{
        cell.transform = CGAffineTransformIdentity;
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self pushToWebViewControllerWithURL:[NSURL URLWithString:@"https://github.com/Xinshuyi"]];
        return;
    }
}

// scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.isScrollToTop = scrollView.contentOffset.y > self.oldContentOffsetY ? NO : YES;
    self.oldContentOffsetY = scrollView.contentOffset.y;
}

// tableview bottom cell delegate
- (void)tableBottomCell:(XSYLoveBeenFirstPageTableBottomCell *)botttomCell didClickIncreaseOrDecreaseButton:(UIButton *)button isIncrease:(BOOL)isIncrease isLeft:(BOOL)isLeft{
    NSLog(@"%d isLeft       %d isIncrease isIncrease",isLeft,isIncrease);
    // 防止加入购物车的商品复用
//    [self.tableView reloadData];
}

// 跳转detailcontroller
- (void)tableBottomCell:(XSYLoveBeenFirstPageTableBottomCell *)bottomCell didClickDetailControllerWithIsLeft:(BOOL)isLeft bottomModel:(XSYLoveBeenFirstPageBottomShoppingModel *)bottomModel{
    XSYLoveBeenFirstPageDetailController *detailController = [[XSYLoveBeenFirstPageDetailController alloc] init];
    detailController.bottomModel = bottomModel;
    [self.navigationController pushViewController:detailController animated:YES];
}

// tableview header delegate
- (void)didClickHeaderView:(XSYLoveBeenTableHeaderView *)header withTopURL:(NSURL *)url{
    [self pushToWebViewControllerWithURL:url];
}

#pragma mark - other method -
- (void)pushToWebViewControllerWithURL:(NSURL *)url{
    XSYLoveBeenFirstPageWebViewController *webviewController = [[XSYLoveBeenFirstPageWebViewController alloc] init];
    [self.navigationController pushViewController:webviewController animated:YES];
    webviewController.url = url;
}
@end
