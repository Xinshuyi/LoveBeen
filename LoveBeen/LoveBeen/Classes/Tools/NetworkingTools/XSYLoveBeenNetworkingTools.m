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

@end
