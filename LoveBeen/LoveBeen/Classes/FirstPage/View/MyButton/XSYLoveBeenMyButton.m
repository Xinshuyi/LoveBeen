//
//  XSYLoveBeenMyButton.m
//  LoveBeen
//
//  Created by xin on 2017/2/20.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenMyButton.h"
#import <Masonry.h>

@interface XSYLoveBeenMyButton ()
@end

@implementation XSYLoveBeenMyButton


- (instancetype)initButtonWithImageString:(NSString *)imageString title:(NSString *)title frame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        // 增加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
        [self addGestureRecognizer:tap];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: imageString]];
        
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-3);
        }];
        
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.text = title;

        titleLable.font = [UIFont systemFontOfSize:11];
        titleLable.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:titleLable];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imageView);
            make.top.equalTo(imageView.mas_bottom).offset(1);
        }];
    }
    return self;
}

- (void)tapView{
    if ([self.delegate respondsToSelector:@selector(didClickMyButton:)]) {
        [self.delegate didClickMyButton:self];
    }
}
@end
