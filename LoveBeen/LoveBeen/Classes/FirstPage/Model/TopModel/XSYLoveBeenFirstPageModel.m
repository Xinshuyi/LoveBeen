//
//  XSYLoveBeenFirstPageModel.m
//  LoveBeen
//
//  Created by xin on 2017/2/18.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenFirstPageModel.h"

@implementation XSYLoveBeenFirstPageModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"activities" :
            @"XSYLoveBeenActivityAndIconModel",               @"focus" :
                 @"XSYLoveBeenFocusModel",
             @"icons" :
        @"XSYLoveBeenActivityAndIconModel"
             };
}

@end
