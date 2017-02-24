//
//  XSYLoveBeenShoppingCarCell.h
//  LoveBeen
//
//  Created by xin on 2017/2/24.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XSYLoveBeenFirstPageBottomShoppingModel,XSYLoveBeenShoppingCarCell;
@protocol XSYLoveBeenShoppingCarCellDelgate <NSObject>
- (void)shoppingCarCell:(XSYLoveBeenShoppingCarCell *)shoppingCarCell didClickDecreaseButtonOrIncreaseIsIncrease:(BOOL)isIncrease shoppingModel:(XSYLoveBeenFirstPageBottomShoppingModel *)shoppingModel;
@end

@interface XSYLoveBeenShoppingCarCell : UITableViewCell

@property (nonatomic, strong) XSYLoveBeenFirstPageBottomShoppingModel *shoppingModel;

@property (nonatomic, weak) id<XSYLoveBeenShoppingCarCellDelgate> delegate;

@end
