//
//  XSYLoveBeenShoppingCarTools.h
//  LoveBeen
//
//  Created by xin on 2017/2/21.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XSYLoveBeenFirstPageBottomShoppingModel;

@interface XSYLoveBeenShoppingCarTools : NSObject

+ (instancetype)shared;

- (void)addShoppingModel:(XSYLoveBeenFirstPageBottomShoppingModel *)shoppingModel;

- (void)deleteShoppingModel:(XSYLoveBeenFirstPageBottomShoppingModel *)shoppingModel;

/**
 商品模型的数组
 */
- (NSArray<XSYLoveBeenFirstPageBottomShoppingModel *> *)getShoppingModels;

/**
获得所有商品的总数
 */
- (NSUInteger)getTotalNumberOfShoppings;


/**
 获得商品总价
 */
- (float)totalPriceOfShoppings;
@end
