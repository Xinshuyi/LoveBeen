//
//  XSYLoveBeenActivityAndIconModel.m
//  LoveBeen
//
//  Created by xin on 2017/2/18.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenActivityAndIconModel.h"

@implementation XSYLoveBeenActivityAndIconModel
// 替换系统关键字 新的 -》 系统关键字
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID" : @"id"};
}
@end
