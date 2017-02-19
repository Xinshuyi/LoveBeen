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

- (void)tableBottomCell:(XSYLoveBeenFirstPageTableBottomCell *)botttomCell didClickIncreaseOrDecreaseButton:(UIButton *)button isIncrease:(BOOL)isIncrease isLeft:(BOOL)isLeft;
@end

@interface XSYLoveBeenFirstPageTableBottomCell : UITableViewCell

@property (nonatomic, strong) XSYLoveBeenFirstPageBottomShoppingModel *leftModel;

@property (nonatomic, strong) XSYLoveBeenFirstPageBottomShoppingModel *rightModel;

@property (nonatomic, weak) id<XSYLoveBeenFirstPageTableBottomCellDelegate> delegate;

@end
