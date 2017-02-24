//
//  XSYLoveBeenShoppingCarTools.m
//  LoveBeen
//
//  Created by xin on 2017/2/21.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenShoppingCarTools.h"
#import "XSYLoveBeenFirstPageBottomShoppingModel.h"

static XSYLoveBeenShoppingCarTools *_shoppingCarTools;

@interface XSYLoveBeenShoppingCarTools ()

@property (nonatomic, strong) NSMutableArray<XSYLoveBeenFirstPageBottomShoppingModel *> *shoppingModels;

@end

@implementation XSYLoveBeenShoppingCarTools

// 实现单例
+ (instancetype)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shoppingCarTools = [[self alloc] init];
        _shoppingCarTools.shoppingModels = [NSMutableArray array];
    });
    return _shoppingCarTools;
}

// 增加商品模型
- (void)addShoppingModel:(XSYLoveBeenFirstPageBottomShoppingModel *)shoppingModel{
    if (![self.shoppingModels containsObject:shoppingModel]) {
        [self.shoppingModels addObject:shoppingModel];
    }
}

// 删除商品
- (void)deleteShoppingModel:(XSYLoveBeenFirstPageBottomShoppingModel *)shoppingModel{
    if (shoppingModel.numOfShopsInShoppingCar == 0) {
        [self.shoppingModels removeObject:shoppingModel];
    }
}

- (NSArray<XSYLoveBeenFirstPageBottomShoppingModel *> *)getShoppingModels{
    return self.shoppingModels;
}

- (NSUInteger)getTotalNumberOfShoppings{
    NSUInteger totalNum = 0;
    for (XSYLoveBeenFirstPageBottomShoppingModel *model in self.shoppingModels) {
        totalNum += model.numOfShopsInShoppingCar;
    }
    return totalNum;
}

- (float)totalPriceOfShoppings{
    float totalPrice;
    for (XSYLoveBeenFirstPageBottomShoppingModel * model in self.shoppingModels) {
        totalPrice += model.partner_price.floatValue * model.numOfShopsInShoppingCar;
    }
    return totalPrice;
}
@end
