//
//  XSYLoveBeenCategoriesModel.h
//  LoveBeen
//
//  Created by xin on 2017/2/21.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XSYLoveBeenFirstPageBottomShoppingModel;

@interface XSYLoveBeenCategoriesModel : NSObject
@property (nonatomic, copy) NSString *disabled_show;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pcid;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *visibility;
@property (nonatomic, strong) NSArray<XSYLoveBeenFirstPageBottomShoppingModel *> *products;
@end
