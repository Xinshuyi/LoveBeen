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
#import "UIButton+Helper.h"
#import "XSYLoveBeenMapController.h"
#import "XSYLoveBeenMyButton.h"
#import "XSYLoveBeenShoppingCarTools.h"
#import "XSYLoveBeenQRControllerViewController.h"
#import "XSYLoveBeenShopCarController.h"
#import "XSYLoveBeenShopingCarNavigationController.h"

static NSString *firstPageTopCellID = @"firstPageTopCellID";
static NSString *firstPageBottomCellID = @"firstPageBottomCellID";

@interface XSYLoveBeenFirstController ()<XSYLoveBeenFirstPageTableBottomCellDelegate, XSYLoveBeenTableHeaderViewDelegate, CAAnimationDelegate,XSYLoveBeenMyButtonDelegate>
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
    [self setTitleView];
    [self setLeftItemAndRightItem];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addNotification];
    [self.tableView reloadData];
    [self setShoppingCarBadge];
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

- (void)setTitleView{
    UIButton *titleButton = [UIButton buttonWithTarget:self action:@selector(clickTitleViewButton:) image:@"icon_mapmarker_small" title:@"在地图中定位" titleFont:[UIFont systemFontOfSize:15] titleColor:[UIColor blackColor]];
    [titleButton sizeToFit];
    self.navigationItem.titleView = titleButton;
}

- (void)setLeftItemAndRightItem{
    XSYLoveBeenMyButton *leftButton = [[XSYLoveBeenMyButton alloc] initButtonWithImageString:@"icon_black_scancode" title:@"扫一扫" frame:CGRectMake(0, 0, 25, 40.453)];
    leftButton.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    XSYLoveBeenMyButton *rightButton = [[XSYLoveBeenMyButton alloc] initButtonWithImageString:@"icon_search" title:@"搜索" frame:CGRectMake(0, 0, 25, 40.453)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

# pragma mark - titleView Event -
- (void)clickTitleViewButton:(UIButton *)tilteButton{
    XSYLoveBeenMapController *mapController = [[XSYLoveBeenMapController alloc] init];
    [self.navigationController pushViewController:mapController animated:YES];
    
    // 接收mapviewcontroller 的地址定位传值
    mapController.mapBlock = ^(NSString *addressStr){
        if (addressStr == nil) {
            return;
        }
        [tilteButton setTitle:addressStr forState:UIControlStateNormal];
    };
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
- (void)tableBottomCell:(XSYLoveBeenFirstPageTableBottomCell *)botttomCell didClickIncreaseOrDecreaseButton:(UIButton *)button withImageView:(UIImageView *)imageView isIncrease:(BOOL)isIncrease isLeft:(BOOL)isLeft{
    NSLog(@"%d isLeft       %d isIncrease isIncrease",isLeft,isIncrease);
    
    // 做动画
    if (isIncrease) {
        
        // 购物车增加商品
        [[XSYLoveBeenShoppingCarTools shared] addShoppingModel:isLeft ? botttomCell.leftModel : botttomCell.rightModel];
        NSArray *array = [[XSYLoveBeenShoppingCarTools shared] getShoppingModels];
        NSLog(@"%@",array);
        
        // 1. 获取起始点
        CGPoint center = [imageView convertPoint:imageView.center toView:[UIApplication sharedApplication].keyWindow];
        CGPoint startPoint = center;
        
        // 2. 终点
        CGPoint endPoint = CGPointMake(ScreenWidth / 4 * 2.5, ScreenHeight - 44);
        
        // 3. 绘制贝塞尔曲线 (一条直线)
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:startPoint];
        [bezierPath addLineToPoint:endPoint];

        // 4. 实例化动画imageview 不能直接用imageview 会被覆盖
        UIImageView *animateImageView = [[UIImageView alloc] initWithImage:imageView.image];
        animateImageView.frame = imageView.frame;
        [[UIApplication sharedApplication].keyWindow addSubview:animateImageView];
       
        // 5. 创建帧动画 作为 发生位移的动画对象
        CAKeyframeAnimation *keyPositionFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        // 设置path
        keyPositionFrame.path = bezierPath.CGPath;
        keyPositionFrame.delegate = self;
        // 保持动画的结束状态
        keyPositionFrame.removedOnCompletion = NO;
        keyPositionFrame.fillMode = kCAFillModeBoth;
        // 设置动画时间
        keyPositionFrame.duration = 1;
        
        [keyPositionFrame setValue:animateImageView forKey:@"animateImageView"];
        

        [animateImageView.layer addAnimation:keyPositionFrame forKey:nil];
        
        
        // 创建使得imageview变小的动画对象
        CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"] ;
        // 没有设置fromvalue说明当前状态作为初始值
        scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
        scaleAnim.duration = 1.1;
        [animateImageView.layer addAnimation:scaleAnim forKey:nil];
    }else{// 购物车减少商品
        [[XSYLoveBeenShoppingCarTools shared] deleteShoppingModel:isLeft ? botttomCell.leftModel : botttomCell.rightModel];
        NSArray *array = [[XSYLoveBeenShoppingCarTools shared] getShoppingModels];
        [self setShoppingCarBadge];
        NSLog(@"%@",array);
    }
}

#pragma mark - 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    UIImageView *animateImageView = [anim valueForKey:@"animateImageView"];
    
    [animateImageView removeFromSuperview];
    
    [self setShoppingCarBadge];
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

// left and right item event
- (void)didClickMyButton:(XSYLoveBeenMyButton *)button{
    if ([button isEqual:self.navigationItem.rightBarButtonItem]) {
        return;
    }
    XSYLoveBeenQRControllerViewController *qrController = [[XSYLoveBeenQRControllerViewController alloc] init];
    [self.navigationController pushViewController:qrController animated:YES];
}

#pragma mark - other method -
- (void)pushToWebViewControllerWithURL:(NSURL *)url{
    XSYLoveBeenFirstPageWebViewController *webviewController = [[XSYLoveBeenFirstPageWebViewController alloc] init];
    [self.navigationController pushViewController:webviewController animated:YES];
    webviewController.url = url;
}

- (void)setShoppingCarBadge{
    XSYLoveBeenShoppingCarTools *tool = [XSYLoveBeenShoppingCarTools shared];
    NSUInteger num = [tool getTotalNumberOfShoppings];
    NSString *numStr = [NSString stringWithFormat:@"%ld",num];
    [self.tabBarController.tabBar.items[2] setBadgeValue:num == 0 ? nil : numStr];
}
@end
