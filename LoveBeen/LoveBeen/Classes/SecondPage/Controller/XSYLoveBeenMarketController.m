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

static NSString *leftTableViewCellID = @"leftTableViewCellID";
static NSString *rightTableViewCellID = @"rightTableViewCellID";

@interface XSYLoveBeenMarketController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray<XSYLoveBeenCategoriesModel *> *mainModelArray;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) NSIndexPath *leftIndexPath;

@end

@implementation XSYLoveBeenMarketController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicSetting];
    [self loadData];
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    [self addConstaints];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
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
}
- (void)loadData{
    [XSYLoveBeenNetworkingTools getMarketPageWithSuccessBlock:^(id response) {
        self.mainModelArray = response;
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        [SVProgressHUD dismiss];
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
        NSLog(@"----2%ld%ld",self.leftIndexPath.section,self.leftIndexPath.row);
        leftCell.isSelected = [self.leftIndexPath isEqual:indexPath] ? YES : NO;
        return leftCell;
    }
    XSYLoveBeenMarketRightCell *rightCell = [tableView dequeueReusableCellWithIdentifier:rightTableViewCellID forIndexPath:indexPath];
    rightCell.shoppingModel = self.mainModelArray[indexPath.section].products[indexPath.row];
    return rightCell;
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
