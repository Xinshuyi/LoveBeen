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

@interface XSYLoveBeenMinePageHeaderView ()
@property (nonatomic, strong) XSYLoveBeenMyButton *orderButton;//v2_my_order_icon
@property (nonatomic, strong) XSYLoveBeenMyButton *discountButton;//v2_my_coupon_icon
@property (nonatomic, strong) XSYLoveBeenMyButton *messageButton;//v2_my_message_icon
@end

@implementation XSYLoveBeenMinePageHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight * 0.1)]) {
        
    }
    return self;
}

#pragma mark - lazy -
- (XSYLoveBeenMyButton *)orderButton{
    if (_orderButton == nil) {
        CGRect frame = CGRectMake(0, 0, ScreenWidth / 3, ScreenHeight);
        _orderButton = [[XSYLoveBeenMyButton alloc] initButtonWithImageString:@"v2_my_order_icon" title:@"我的订单" frame:frame];
    }
    return _orderButton;
}

- (XSYLoveBeenMyButton *)discountButton{
    if (_discountButton == nil) {
        CGRect frame = CGRectMake(ScreenWidth / 3, 0, ScreenWidth / 3, ScreenHeight);
        _discountButton = [[XSYLoveBeenMyButton alloc] initButtonWithImageString:@"v2_my_coupon_icon" title:@"我的优惠" frame:frame];
    }
    return _discountButton;
}

- (XSYLoveBeenMyButton *)messageButton{
    if (_messageButton == nil) {
        CGRect frame = CGRectMake(ScreenWidth / 3 * 2, 0, ScreenWidth / 3, ScreenHeight);
        _messageButton = [[XSYLoveBeenMyButton alloc] initButtonWithImageString:@"v2_my_message_icon" title:@"我的消息" frame:frame];
    }
    return _messageButton;
}
@end
