//
//  XSYLoveBeenShoppingController.m
//  LoveBeen
//
//  Created by xin on 2017/2/18.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//
#import <Masonry.h>
#import "XSYLoveBeenShopCarController.h"
#import "UIBarButtonItem+Extension.h"
#import "XSYLoveBeenShoppingCarTools.h"
#import "XSYLoveBeenShoppingCarOriginView.h"
#import "XSYLoveBeenFirstPageBottomShoppingModel.h"
#import "XSYLoveBeenShoppingCarCell.h"
#import "UILabel+Helper.h"
#import "XSYLoveBeenShoppingCarToolBar.h"

static NSString *shoppingCarCell = @"shoppingCarCell";

@interface XSYLoveBeenShopCarController ()<XSYLoveBeenShoppingCarCellDelgate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) XSYLoveBeenShoppingCarOriginView *originView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) XSYLoveBeenShoppingCarTools *shoppingCarTools;
@property (nonatomic, assign) BOOL isOriginView;
@property (nonatomic, strong) XSYLoveBeenShoppingCarToolBar *toolBar;
@end

@implementation XSYLoveBeenShopCarController

- (void)loadView{
    if ([self.shoppingCarTools getShoppingModels].count == 0) {
        self.view = self.originView;
        
        self.isOriginView = YES;
        
        return;
    }
    self.isOriginView = NO;
    
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicSetting];
    if (!self.isOriginView) {
        [self.view addSubview:self.tableView];
        [self.view addSubview:self.toolBar];
        [self addConstraints];
    }
}
- (void)clickOkButton:(UIButton *)okButton{
    
}

- (void)addConstraints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.bottom.equalTo(self.view);
    }];
    
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(45);
    }];
}

- (void)basicSetting{
    self.title = @"购物车";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(dismissNavigationController) image:@"cell_arrow_down_accessory" isLeft:YES];
}

// dismiss
- (void)dismissNavigationController{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - dataSource and delegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.shoppingCarTools getShoppingModels].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XSYLoveBeenShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:shoppingCarCell forIndexPath:indexPath];
    cell.shoppingModel = [self.shoppingCarTools getShoppingModels][indexPath.row];
    cell.delegate = self;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[[NSBundle mainBundle] loadNibNamed:@"ShoppingCarTableSectionHeaderView" owner:nil options:nil] lastObject];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 149;
}

- (void)shoppingCarCell:(XSYLoveBeenShoppingCarCell *)shoppingCarCell didClickDecreaseButtonOrIncreaseIsIncrease:(BOOL)isIncrease shoppingModel:(XSYLoveBeenFirstPageBottomShoppingModel *)shoppingModel{
    self.toolBar.totalPriceLabel.text = [NSString stringWithFormat:@"%f",[self.shoppingCarTools totalPriceOfShoppings]];
}

#pragma mark - lazy -
- (XSYLoveBeenShoppingCarOriginView *)originView{
    if (_originView == nil) {
        _originView = [[XSYLoveBeenShoppingCarOriginView alloc] init];
        
        __weak XSYLoveBeenShopCarController *weakSelf = self;
        
        _originView.dismissBlock = ^{
            [weakSelf dismissNavigationController];
        };
    }
    return _originView;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        UINib *nib = [UINib nibWithNibName:@"XSYLoveBeenShoppingCarCell" bundle:[NSBundle mainBundle]];
        [_tableView registerNib:nib forCellReuseIdentifier:shoppingCarCell];
        _tableView.tableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingCarTableHeaderView" owner:nil options:nil] lastObject];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (XSYLoveBeenShoppingCarTools *)shoppingCarTools{
    if (_shoppingCarTools == nil) {
        _shoppingCarTools = [XSYLoveBeenShoppingCarTools shared];
    }
    return _shoppingCarTools;
}

- (XSYLoveBeenShoppingCarToolBar *)toolBar{
    if (_toolBar == nil) {
        _toolBar = [[XSYLoveBeenShoppingCarToolBar alloc] init];
        _toolBar.okButtonTarget = self;
        _toolBar.totalPriceLabel.text = [NSString stringWithFormat:@"￥%.1f",[self.shoppingCarTools totalPriceOfShoppings]];
    }
    return _toolBar;
}
@end
