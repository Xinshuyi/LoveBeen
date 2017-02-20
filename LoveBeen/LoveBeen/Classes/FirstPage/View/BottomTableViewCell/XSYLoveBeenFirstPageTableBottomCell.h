//
//  XSYLoveBeenFirstPageTableBottomCell.h
//  LoveBeen
//
//  Created by xin on 2017/2/19.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XSYLoveBeenFirstPageBottomShoppingModel,XSYLoveBeenFirstPageTableBottomCell;

@protocol XSYLoveBeenFirstPageTableBottomCellDelegate <NSObject>

// 防止复用 和 做动画
- (void)tableBottomCell:(XSYLoveBeenFirstPageTableBottomCell *)botttomCell didClickIncreaseOrDecreaseButton:(UIButton *)button isIncrease:(BOOL)isIncrease isLeft:(BOOL)isLeft;

// 点进详情页面
- (void)tableBottomCell:(XSYLoveBeenFirstPageTableBottomCell *)bottomCell didClickDetailControllerWithIsLeft:(BOOL)isLeft bottomModel:(XSYLoveBeenFirstPageBottomShoppingModel *)bottomModel;
@end

@interface XSYLoveBeenFirstPageTableBottomCell : UITableViewCell

@property (nonatomic, strong) XSYLoveBeenFirstPageBottomShoppingModel *leftModel;

@property (nonatomic, strong) XSYLoveBeenFirstPageBottomShoppingModel *rightModel;

@property (nonatomic, weak) id<XSYLoveBeenFirstPageTableBottomCellDelegate> delegate;

@end
