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
#import "XSYLoveBeenMinePageTopView.h"
#import "XSYLoveBeenMinePageHeaderView.h"
#import "XSYLoveBeenViewMinePageDetailController.h"
#import <Masonry.h>

static NSString *minePageCellID = @"minePageCellID";

@interface XSYLoveBeenMineController ()<UINavigationControllerDelegate,
    UITableViewDelegate,
    UITableViewDataSource>

@property (nonatomic, strong) XSYLoveBeenMinePageTopView *topView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation XSYLoveBeenMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 隐藏导航栏
    self.navigationController.delegate = self;
    
    [self.view addSubview:self.topView];
    
    [self addConstraints];
}

- (void)addConstraints{
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(self.view).multipliedBy(0.23);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
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

#pragma mark - delegate datasource -
// navigationcontroller delegate 隐藏导航栏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    BOOL isHiddenNavigationBar = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isHiddenNavigationBar animated:YES];
}

// datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:minePageCellID forIndexPath:indexPath];
    return cell;
}

#pragma mark - lazy -
- (XSYLoveBeenMinePageTopView *)topView{
    if (_topView == nil) {
        _topView = [[XSYLoveBeenMinePageTopView alloc] init];
    }
    return _topView;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        XSYLoveBeenViewMinePageDetailController *vc = [[XSYLoveBeenViewMinePageDetailController alloc] init];
        _tableView = vc.tableView;
        [self addChildViewController:vc];
        [self.view addSubview:vc.tableView];
        [vc didMoveToParentViewController:self];
    }
    return _tableView;
}
@end
