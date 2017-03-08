//
//  XSYLoveBeenMinePageHeaderView.m
//  LoveBeen
//
//  Created by xin on 2017/3/6.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenMinePageHeaderView.h"
#import "XSYLoveBeenMyButton.h"
#import "CZAdditions.h"
#import <Masonry.h>

#define buttonHeight self.frame.size.height * 0.7
#define separatorHeight self.frame.size.height * 0.3

@interface XSYLoveBeenMinePageHeaderView ()
@property (nonatomic, strong) XSYLoveBeenMyButton *orderButton;//v2_my_order_icon
@property (nonatomic, strong) XSYLoveBeenMyButton *discountButton;//v2_my_coupon_icon
@property (nonatomic, strong) XSYLoveBeenMyButton *messageButton;//v2_my_message_icon
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIView *separatorView;
@end

@implementation XSYLoveBeenMinePageHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.orderButton];
        [self addSubview:self.discountButton];
        [self addSubview:self.messageButton];
        [self addSubview:self.line1];
        [self addSubview:self.line2];
        [self addSubview:self.separatorView];
    }
    return self;
}

#pragma mark - lazy -
- (XSYLoveBeenMyButton *)orderButton{
    if (_orderButton == nil) {
        CGRect frame = CGRectMake(0, 0, ScreenWidth / 3, buttonHeight);
        _orderButton = [[XSYLoveBeenMyButton alloc] initButtonWithImageString:@"v2_my_order_icon" title:@"我的订单" frame:frame];
    }
    return _orderButton;
}

- (XSYLoveBeenMyButton *)discountButton{
    if (_discountButton == nil) {
        CGRect frame = CGRectMake(ScreenWidth / 3, 0, ScreenWidth / 3, buttonHeight);
        _discountButton = [[XSYLoveBeenMyButton alloc] initButtonWithImageString:@"v2_my_coupon_icon" title:@"我的优惠" frame:frame];
    }
    return _discountButton;
}

- (XSYLoveBeenMyButton *)messageButton{
    if (_messageButton == nil) {
        CGRect frame = CGRectMake(ScreenWidth / 3 * 2, 0, ScreenWidth / 3, buttonHeight);
        _messageButton = [[XSYLoveBeenMyButton alloc] initButtonWithImageString:@"v2_my_message_icon" title:@"我的消息" frame:frame];
    }
    return _messageButton;
}

- (UIView *)line1{
    if (_line1 == nil) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor lightGrayColor];
        _line1.center = CGPointMake(ScreenWidth / 3, buttonHeight / 2);
        _line1.bounds = CGRectMake(0, 0, 1, buttonHeight * 0.8);
    }
    return _line1;
}

- (UIView *)line2{
    if (_line2 == nil) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor lightGrayColor];
        _line2.center = CGPointMake(ScreenWidth / 3 * 2, buttonHeight / 2);
        _line2.bounds = CGRectMake(0, 0, 1, buttonHeight * 0.8);
    }
    return _line2;
}

- (UIView *)separatorView{
    if (_separatorView == nil) {
        _separatorView = [[UIView alloc] init];
        _separatorView.backgroundColor = [UIColor cz_colorWithRed:239 green:239 blue:239];
        _separatorView.frame = CGRectMake(0, buttonHeight, ScreenWidth, separatorHeight);
    }
    return _separatorView;
}
@end
