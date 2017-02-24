//
//  XSYLoveBeenShoppingCarOriginView.m
//  LoveBeen
//
//  Created by xin on 2017/2/23.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenShoppingCarOriginView.h"
#import "CZAdditions.h"
#import "UILabel+Helper.h"
#import "UIButton+Helper.h"
#import <Masonry.h>

@implementation XSYLoveBeenShoppingCarOriginView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        
        self.backgroundColor = [UIColor cz_colorWithRed:235 green:235 blue:235];
        
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"v2_shop_empty"]];
        UILabel *label = [UILabel labelWithtextColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:18] text:@"亲,购物车空空的耶~赶紧挑好吃的吧"];
        UIButton *button = [UIButton buttonWithTarget:self action:@selector(dismissNavigationController) image:nil title:@"去逛逛" titleFont:[UIFont systemFontOfSize:15] titleColor:[UIColor lightGrayColor]];
        
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1;
        
        [self addSubview:iconView];
        [self addSubview:label];
        [self addSubview:button];
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-80);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(iconView);
            make.centerY.equalTo(self).offset(40);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
    }
    return self;
}

- (void)dismissNavigationController{
    if (_dismissBlock) {
        _dismissBlock();
    }
}
@end
