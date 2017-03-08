//
//  HQCommonItem.m
//  ListenToThis
//
//  Created by zhq on 15/10/4.
//  Copyright © 2015年 zhq. All rights reserved.
//

#import "HQCommonItem.h"

@implementation HQCommonItem
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    HQCommonItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}
+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title icon:nil];
}

@end
