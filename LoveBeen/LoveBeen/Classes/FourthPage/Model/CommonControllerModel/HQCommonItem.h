//
//  HQCommonItem.h
//  ListenToThis
//
//  Created by zhq on 15/10/4.
//  Copyright © 2015年 zhq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQCommonItem : NSObject
/** 图标 */
@property (nonatomic, copy) NSString *icon;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 点击这行cell，需要调转到哪个控制器 */
@property (nonatomic, assign) Class destVcClass;
/** 封装点击这行cell想做的事情 */
// block 只能用 copy
@property (nonatomic, copy) void (^operation)();
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+ (instancetype)itemWithTitle:(NSString *)title;
@end
