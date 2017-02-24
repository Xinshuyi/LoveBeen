//
//  XSYLoveBeenShoppingController.m
//  LoveBeen
//
//  Created by xin on 2017/2/18.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenMarketController.h"
#import "XSYLoveBeenNetworkingTools.h"
#import "XSYLoveBeenCategoriesModel.h"
#import <SVProgressHUD.h>
#import "XSYLoveBeenFirstPageBottomShoppingModel.h"
#import <SVProgressHUD.h>
#import <Masonry.h>
#import "XSYLoveBeenMarketLeftCell.h"
#import "XSYLoveBeenMarketRightCell.h"
#import <MJRefresh.h>
#import "XSYRefreshHeader.h"
#import "XSYLoveBeenShoppingCarTools.h"
#import "XSYLoveBeenShopCarController.h"
#import "XSYLoveBeenShopingCarNavigationController.h"

static NSString *leftTableViewCellID = @"leftTableViewCellID";
static NSString *rightTableViewCellID = @"rightTableViewCellID";

@interface XSYLoveBeenMarketController ()<UITableViewDelegate, UITableViewDataSource,XSYLoveBeenMarketRightCellDelegate, CAAnimationDelegate>
@property (nonatomic, strong) NSMutableArray<XSYLoveBeenCategoriesModel *> *mainModelArray;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) NSIndexPath *leftIndexPath;
@end

@implementation XSYLoveBeenMarketController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicSetting];
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    [self addConstaints];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kShoppingCarControllerModal object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addNotification];
    [self.rightTableView reloadData];
    [self showShoppingCarTotalNumber];
}

- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modalShoppingViewController) name:kShoppingCarControllerModal object:nil];
}

- (void)modalShoppingViewController{
    XSYLoveBeenShopCarController *shopController = [[XSYLoveBeenShopCarController alloc] init];
    XSYLoveBeenShopingCarNavigationController *shopCarController = [[XSYLoveBeenShopingCarNavigationController alloc] initWithRootViewController:shopController];
    [self presentViewController:shopCarController animated:YES completion:nil];
}

- (void)addConstaints{
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.width.mas_equalTo(ScreenWidth * 0.3);
    }];
    
    [self.rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.width.mas_equalTo(ScreenWidth * 0.7);
    }];
}
- (void)basicSetting{
    self.view.backgroundColor = [UIColor whiteColor];
    [SVProgressHUD show];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.leftIndexPath = indexPath;
    XSYRefreshHeader *header = [XSYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    self.rightTableView.mj_header = header;
    [self.rightTableView.mj_header beginRefreshing];

}
- (void)loadData{
    [XSYLoveBeenNetworkingTools getMarketPageWithSuccessBlock:^(id response) {
        self.mainModelArray = response;
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        [SVProgressHUD dismiss];
        [self.rightTableView.mj_header endRefreshing];
    } FailureBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络不佳"];
    }];
}

#pragma mark - datasource and delegate -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.leftTableView]) {
        self.leftIndexPath = indexPath;
        [self.leftTableView reloadData];
        
        // 让右边的tableview滚动到相应位置
        NSIndexPath *rightIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        [self.rightTableView scrollToRowAtIndexPath:rightIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.rightTableView] && (self.rightTableView.isDragging || self.rightTableView.isDecelerating || self.rightTableView.isTracking)) {
        self.leftIndexPath = [NSIndexPath indexPathForRow:indexPath.section inSection:0];
        [self.leftTableView scrollToRowAtIndexPath:self.leftIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        [self.leftTableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([tableView isEqual:self.leftTableView]) {
        return 1;
    }
    return self.mainModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.leftTableView]) {
        return self.mainModelArray.count;
    }
    return self.mainModelArray[section].products.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:self.rightTableView]) {
        return self.mainModelArray[section].name;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:self.leftTableView]) {
        return 0;
    }
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.leftTableView]) {
        
        XSYLoveBeenMarketLeftCell *leftCell = [tableView dequeueReusableCellWithIdentifier:leftTableViewCellID forIndexPath:indexPath];
        leftCell.categoriesModel = self.mainModelArray[indexPath.row];

        leftCell.isSelected = [self.leftIndexPath isEqual:indexPath] ? YES : NO;
        
        return leftCell;
    }
    
    XSYLoveBeenMarketRightCell *rightCell = [tableView dequeueReusableCellWithIdentifier:rightTableViewCellID forIndexPath:indexPath];
    
    rightCell.shoppingModel = self.mainModelArray[indexPath.section].products[indexPath.row];
    
    rightCell.delegate = self;
    
    return rightCell;
}

#pragma mark - right cell delegate -
- (void)rightCell:(XSYLoveBeenMarketRightCell *)rightCell didClickDecreaseButtonOrIncreaseIsIncrease:(BOOL)isIncrease WithImageView:(UIImageView *)imageView shoppingModel:(XSYLoveBeenFirstPageBottomShoppingModel *)shoppingModel{
    
    if (isIncrease) {
        // 加入购物车
        [self addShoppingCarWithShoppingModel:shoppingModel];
        // 做动画
        [self animationWithImageView:imageView];
        
            }else{
        // 从购物车减去
        [self deleteShoppingCarWithShoppingModel:shoppingModel];
    }
}

#pragma mark - animate delegate -
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    UIImageView *imageView = [anim valueForKey:@"animateImageView"];
    [imageView removeFromSuperview];
    
    // 动画结束后显示购物车的物品数量
    [self showShoppingCarTotalNumber];
}

#pragma mark - other method -

- (void)animationWithImageView:(UIImageView *)imageView{
    // 1. 起点
    CGPoint startPoint = [imageView convertPoint:imageView.center toView:[UIApplication sharedApplication].keyWindow];
    // 2. 终点
    CGPoint endPoint = CGPointMake(ScreenWidth / 4 * 2.5, ScreenHeight - 44);
    // 创建使得imageview移动的动画对象
    CABasicAnimation *positionAnim = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnim.fromValue = [NSValue valueWithCGPoint:startPoint];
    positionAnim.toValue = [NSValue valueWithCGPoint:endPoint];
    positionAnim.duration = 1;
    positionAnim.delegate = self;
    positionAnim.removedOnCompletion = NO;
    positionAnim.fillMode = kCAFillModeBoth;
    
    UIImageView *animateImageView = [[UIImageView alloc] initWithFrame:imageView.frame];
    animateImageView.image = imageView.image;
    
    [positionAnim setValue:animateImageView forKey:@"animateImageView"];
    
    [[UIApplication sharedApplication].keyWindow addSubview:animateImageView];
    
    [animateImageView.layer addAnimation:positionAnim forKey:nil];
    
    // 创建使得imageview变小的动画对象
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"] ;
    // 没有设置fromvalue说明当前状态作为初始值
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
    scaleAnim.duration = 1.1;
    [animateImageView.layer addAnimation:scaleAnim forKey:nil];
}

- (void)showShoppingCarTotalNumber{
    XSYLoveBeenShoppingCarTools *shoppingTools = [XSYLoveBeenShoppingCarTools shared];
    NSUInteger totalNum = [shoppingTools getTotalNumberOfShoppings];
    [self.tabBarController.tabBar.items[2] setBadgeValue:totalNum == 0 ? nil : [NSString stringWithFormat:@"%ld",totalNum]];
}

- (void)addShoppingCarWithShoppingModel:(XSYLoveBeenFirstPageBottomShoppingModel *)shoppingModel{
    [[XSYLoveBeenShoppingCarTools shared] addShoppingModel:shoppingModel];
}

- (void)deleteShoppingCarWithShoppingModel:(XSYLoveBeenFirstPageBottomShoppingModel *)shoppingModel{
    [[XSYLoveBeenShoppingCarTools shared] deleteShoppingModel:shoppingModel];
    
    // 显示真正数量
    [self showShoppingCarTotalNumber];
}

#pragma mark - lazy -
- (UITableView *)leftTableView{
    if (_leftTableView == nil) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_leftTableView registerClass:[XSYLoveBeenMarketLeftCell class] forCellReuseIdentifier:leftTableViewCellID];
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        _leftTableView.showsVerticalScrollIndicator = NO;
    }
    return _leftTableView;
}

- (UITableView *)rightTableView{
    if (_rightTableView == nil) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_rightTableView registerClass:[XSYLoveBeenMarketRightCell class] forCellReuseIdentifier:rightTableViewCellID];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.showsVerticalScrollIndicator = NO;
        _rightTableView.rowHeight = 80;
    }
    return _rightTableView;
}


@end
