//
//  XSYLoveBeenCategoriesModel.m
//  LoveBeen
//
//  Created by xin on 2017/2/21.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenCategoriesModel.h"

@implementation XSYLoveBeenCategoriesModel
// 替换系统关键字 新的 -》 系统关键字
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID" : @"id"};
}
@end
