//
//  XSYLoveBeenMyButton.h
//  LoveBeen
//
//  Created by xin on 2017/2/20.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XSYLoveBeenMyButton;

@protocol XSYLoveBeenMyButtonDelegate <NSObject>

- (void)didClickMyButton:(XSYLoveBeenMyButton *)button;
@end

@interface XSYLoveBeenMyButton : UIView

@property (nonatomic, weak) id<XSYLoveBeenMyButtonDelegate> delegate;


- (instancetype)initButtonWithImageString:(NSString *)imageString title:(NSString *)title frame:(CGRect)frame;

@end
