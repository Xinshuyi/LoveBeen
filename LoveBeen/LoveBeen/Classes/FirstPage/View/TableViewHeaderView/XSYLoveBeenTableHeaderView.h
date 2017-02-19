//
//  XSYLoveBeenTableHeaderView.h
//  LoveBeen
//
//  Created by xin on 2017/2/18.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XSYLoveBeenFirstPageModel,XSYLoveBeenTableHeaderView;

@protocol XSYLoveBeenTableHeaderViewDelegate <NSObject>

- (void)didClickHeaderView:(XSYLoveBeenTableHeaderView *)header withTopURL:(NSURL *)url;

@end

@interface XSYLoveBeenTableHeaderView : UIView

@property (nonatomic, weak) id<XSYLoveBeenTableHeaderViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame andTopMainModel:(XSYLoveBeenFirstPageModel *)topMainModel;

@end
