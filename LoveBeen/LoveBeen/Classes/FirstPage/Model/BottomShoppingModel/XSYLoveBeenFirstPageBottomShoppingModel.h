//
//  XSYLoveBeenFirstPageBottomShoppingModel.h
//  LoveBeen
//
//  Created by xin on 2017/2/19.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSYLoveBeenFirstPageBottomShoppingModel : NSObject
@property (nonatomic, copy) NSString *img;

/**
 商品名
 */
@property (nonatomic, copy) NSString *name;

/**
 优惠
 */
@property (nonatomic, copy) NSString *pm_desc;

/**
 大小 毫升 分量
 */
@property (nonatomic, copy) NSString *specifics;

/**
 剩余数量
 */
@property (nonatomic, assign) NSUInteger number;

/**
 现在价格
 */
@property (nonatomic, copy) NSString *partner_price;

/**
 打折前价格
 */
@property (nonatomic, copy) NSString *market_price;

/**
 加入购物车的商品数目
 */
@property (nonatomic, assign) NSUInteger numOfShopsInShoppingCar;

/**
 品牌
 */
@property (nonatomic, copy) NSString *brand_name;

/**
 加号是否隐藏
 */
@property (nonatomic, assign) BOOL isIncreaseButtonHidden;

/**
 减号是否隐藏
 */
@property (nonatomic, assign) BOOL isDecreaseButtonHidden;

@end
