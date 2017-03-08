//
//  HQCommonGroup.h
//  ListenToThis
//
//  Created by zhq on 15/10/4.
//  Copyright © 2015年 zhq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQCommonGroup : NSObject
/** 这组的所有行模型(数组中存放的都是HMCommonItem模型) */
@property (nonatomic, strong) NSArray *items;

+ (instancetype)group;
@end
