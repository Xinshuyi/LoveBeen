//
//  XSYLoveBeenShoppingCarToolBar.m
//  LoveBeen
//
//  Created by xin on 2017/2/24.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenShoppingCarToolBar.h"
#import <Masonry.h>
#import "UILabel+Helper.h"
#import "UIButton+Helper.h"

@implementation XSYLoveBeenShoppingCarToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.totalPriceLabel];
        [self addSubview:self.okButton];
        [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(10);
            make.centerY.equalTo(self);
        }];
        
        [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

- (UILabel *)totalPriceLabel{
    if (_totalPriceLabel == nil) {
        _totalPriceLabel = [UILabel labelWithtextColor:[UIColor redColor] font:[UIFont systemFontOfSize:15]];
    }
    return _totalPriceLabel;
}

- (UIButton *)okButton{
    if (_okButton == nil) {
        _okButton = [UIButton buttonWithTarget:_okButtonTarget action:@selector(clickOkButton:) image:nil title:@"选好了" titleFont:[UIFont systemFontOfSize:16] titleColor:[UIColor whiteColor]];
        _okButton.backgroundColor = mainColor;
    }
    return _okButton;
}
@end
