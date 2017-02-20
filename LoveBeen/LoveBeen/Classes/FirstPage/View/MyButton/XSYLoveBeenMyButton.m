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
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: imageString]];
        
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.equalTo(self);
            make.height.equalTo(imageView.mas_width);
        }];
        
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.text = title;

        titleLable.font = [UIFont systemFontOfSize:11];
        titleLable.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:titleLable];
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imageView);
            make.top.equalTo(imageView.mas_bottom);
        }];
    }
    return self;

}
@end
