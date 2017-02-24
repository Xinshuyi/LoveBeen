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

@interface XSYLoveBeenShopCarController ()<XSYLoveBeenShoppingCarCellDelgate>
@property (nonatomic, strong) XSYLoveBeenShoppingCarOriginView *originView;
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
        [self initialTableView];
    }
}
- (void)clickOkButton:(UIButton *)okButton{
    
}

- (void)initialTableView{
    UINib *nib = [UINib nibWithNibName:@"XSYLoveBeenShoppingCarCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:shoppingCarCell];
    self.tableView.tableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingCarTableHeaderView" owner:nil options:nil] lastObject];
    [self.tableView addSubview:self.toolBar];
    self.toolBar.okButtonTarget = self;
    self.toolBar.totalPriceLabel.text = [NSString stringWithFormat:@"￥%.1f",[self.shoppingCarTools totalPriceOfShoppings]];
    self.tableView.tableFooterView = [[UIView alloc] init];
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

- (XSYLoveBeenShoppingCarTools *)shoppingCarTools{
    if (_shoppingCarTools == nil) {
        _shoppingCarTools = [XSYLoveBeenShoppingCarTools shared];
    }
    return _shoppingCarTools;
}

- (XSYLoveBeenShoppingCarToolBar *)toolBar{
    if (_toolBar == nil) {
        _toolBar = [[XSYLoveBeenShoppingCarToolBar alloc] initWithFrame:CGRectMake(0, 0.9 * ScreenHeight - 64, ScreenWidth, 0.1 * ScreenHeight)];
    }
    return _toolBar;
}
@end
