//
//  XSYLoveBeenMinePageHeaderView.m
//  LoveBeen
//
//  Created by xin on 2017/3/6.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenMinePageHeaderView.h"
#import "XSYLoveBeenMyButton.h"
#import <Masonry.h>

#define Height self.frame.size.height

@interface XSYLoveBeenMinePageHeaderView ()
@property (nonatomic, strong) XSYLoveBeenMyButton *orderButton;//v2_my_order_icon
@property (nonatomic, strong) XSYLoveBeenMyButton *discountButton;//v2_my_coupon_icon
@property (nonatomic, strong) XSYLoveBeenMyButton *messageButton;//v2_my_message_icon
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@end

@implementation XSYLoveBeenMinePageHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.orderButton];
        [self addSubview:self.discountButton];
        [self addSubview:self.messageButton];
        [self addSubview:self.line1];
        [self addSubview:self.line2];
    }
    return self;
}

#pragma mark - lazy -
- (XSYLoveBeenMyButton *)orderButton{
    if (_orderButton == nil) {
        CGRect frame = CGRectMake(0, 0, ScreenWidth / 3, Height);
        _orderButton = [[XSYLoveBeenMyButton alloc] initButtonWithImageString:@"v2_my_order_icon" title:@"我的订单" frame:frame];
    }
    return _orderButton;
}

- (XSYLoveBeenMyButton *)discountButton{
    if (_discountButton == nil) {
        CGRect frame = CGRectMake(ScreenWidth / 3, 0, ScreenWidth / 3, Height);
        _discountButton = [[XSYLoveBeenMyButton alloc] initButtonWithImageString:@"v2_my_coupon_icon" title:@"我的优惠" frame:frame];
    }
    return _discountButton;
}

- (XSYLoveBeenMyButton *)messageButton{
    if (_messageButton == nil) {
        CGRect frame = CGRectMake(ScreenWidth / 3 * 2, 0, ScreenWidth / 3, Height);
        _messageButton = [[XSYLoveBeenMyButton alloc] initButtonWithImageString:@"v2_my_message_icon" title:@"我的消息" frame:frame];
    }
    return _messageButton;
}

- (UIView *)line1{
    if (_line1 == nil) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor lightGrayColor];
        _line1.center = CGPointMake(ScreenWidth / 3, Height / 2);
        _line1.bounds = CGRectMake(0, 0, 1, Height * 0.8);
    }
    return _line1;
}

- (UIView *)line2{
    if (_line2 == nil) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor lightGrayColor];
        _line2.center = CGPointMake(ScreenWidth / 3 * 2, Height / 2);
        _line2.bounds = CGRectMake(0, 0, 1, Height * 0.8);
    }
    return _line2;
}
@end
