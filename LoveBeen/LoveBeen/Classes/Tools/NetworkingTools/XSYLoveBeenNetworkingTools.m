//
//  XSYLoveBeenNetworkingTools.m
//  LoveBeen
//
//  Created by xin on 2017/2/18.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenNetworkingTools.h"
#import "NetworkingTools.h"
#import <MJExtension.h>
#import "XSYLoveBeenFirstPageModel.h"
#import "XSYLoveBeenFirstPageBottomShoppingModel.h"
#import "XSYLoveBeenCategoriesModel.h"

@implementation XSYLoveBeenNetworkingTools
+ (void)getFirstPageDataWithSuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock{
    NSString *urlStr = @"http://iosapi.itcast.cn/loveBeen/focus.json.php";
    NSDictionary *dict = @{@"call" : @"1"};
    [[NetworkingTools shared] request:POST urlString:urlStr parameters:dict completeBlock:^(id response, NSError *error) {
        if (error == nil) {
            XSYLoveBeenFirstPageModel *model = [XSYLoveBeenFirstPageModel mj_objectWithKeyValues:response[@"data"]];
            if (successBlock) {
                successBlock(model);
            }
        }else{
            if (failureBlock) {
                failureBlock(error);
            }
        }
    }];
}

+ (void)getFirstPageBottomWithSuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock{
    NSDictionary *para = @{@"call" : @"2"};
    [[NetworkingTools shared] request:POST urlString:@"http://iosapi.itcast.cn/loveBeen/firstSell.json.php" parameters:para completeBlock:^(id response, NSError *error) {
        if (error == nil) {
            NSArray *modelArr = [XSYLoveBeenFirstPageBottomShoppingModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
            for (XSYLoveBeenFirstPageBottomShoppingModel *model in modelArr) {
                model.numOfShopsInShoppingCar = 0;
                model.isDecreaseButtonHidden = YES;
                model.isIncreaseButtonHidden = (model.number == 0);
            }
            if (successBlock) {
                successBlock(modelArr);
            }
        }else{
            if (failureBlock) {
                failureBlock(error);
            }
        }
    }];
}

+ (void)getMarketPageWithSuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock{
    NSString *urlStr = @"http://iosapi.itcast.cn/loveBeen/supermarket.json.php";
    NSDictionary *para = @{@"call":@"5"};
    [[NetworkingTools shared] request:POST urlString:urlStr parameters:para completeBlock:^(id response, NSError *error) {
        if (error == nil) {
            NSArray<XSYLoveBeenCategoriesModel *> *categories = [XSYLoveBeenCategoriesModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"categories"]];
            for (int i = 0; i < categories.count; i ++) {
                NSString *key = categories[i].ID;
                NSArray *miniArray = response[@"data"][@"products"][key];
                categories[i].products = [XSYLoveBeenFirstPageBottomShoppingModel mj_objectArrayWithKeyValuesArray:miniArray];
                for (XSYLoveBeenFirstPageBottomShoppingModel *model in categories[i].products) {
                    model.numOfShopsInShoppingCar = 0;
                    model.isDecreaseButtonHidden = YES;
                    model.isIncreaseButtonHidden = (model.number == 0);
                }
            }
            if (successBlock) {
                successBlock(categories);
            }
        }else{
            
        }
    }];
}
@end
