//
//  XSYLoveBeenFirstPageModel.h
//  LoveBeen
//
//  Created by xin on 2017/2/18.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XSYLoveBeenFocusModel;
@class XSYLoveBeenActivityAndIconModel;

@interface XSYLoveBeenFirstPageModel : NSObject
@property (nonatomic, strong) NSArray<XSYLoveBeenActivityAndIconModel *> *activities;
@property (nonatomic, strong) NSArray<XSYLoveBeenFocusModel *> *focus;
@property (nonatomic, strong) NSArray<XSYLoveBeenActivityAndIconModel *> *icons;
@end
