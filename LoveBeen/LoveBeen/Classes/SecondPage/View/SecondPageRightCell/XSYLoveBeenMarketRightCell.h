//
//  XSYLoveBeenMarketRightCell.h
//  LoveBeen
//
//  Created by xin on 2017/2/22.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XSYLoveBeenFirstPageBottomShoppingModel,XSYLoveBeenMarketRightCell;
@protocol XSYLoveBeenMarketRightCellDelegate <NSObject>

- (void)rightCell:(XSYLoveBeenMarketRightCell *)rightCell didClickDecreaseButtonOrIncreaseIsIncrease:(BOOL)isIncrease WithImageView:(UIImageView *)imageView shoppingModel:(XSYLoveBeenFirstPageBottomShoppingModel *)shoppingModel;

@end

@interface XSYLoveBeenMarketRightCell : UITableViewCell

@property (nonatomic, strong) XSYLoveBeenFirstPageBottomShoppingModel *shoppingModel;

@property (nonatomic, weak) id<XSYLoveBeenMarketRightCellDelegate> delegate;

@end
