//
//  XSYLoveBeenNetworkingTools.h
//  LoveBeen
//
//  Created by xin on 2017/2/18.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id response);
typedef void(^FailureBlock)(NSError *error);

@interface XSYLoveBeenNetworkingTools : NSObject
+ (void)getFirstPageDataWithSuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock;
@end
