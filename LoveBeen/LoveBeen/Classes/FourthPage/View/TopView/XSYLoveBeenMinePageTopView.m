//
//  XSYLoveBeenMinePageTopView.m
//  LoveBeen
//
//  Created by xin on 2017/3/6.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenMinePageTopView.h"
#import <Masonry.h>
#import "UIButton+Helper.h"
#import "UILabel+Helper.h"

#define IconViewHW 80

@interface XSYLoveBeenMinePageTopView ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *settingButton;
@property (nonatomic, strong) UIImageView *backgroundView;
@end

@implementation XSYLoveBeenMinePageTopView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.backgroundView];
        [self addSubview:self.iconView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.settingButton];
        [self addConstraints];
    }
    return self;
}

- (void)addConstraints{
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
   
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(IconViewHW, IconViewHW));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).offset(8);
        make.centerX.equalTo(self.iconView);
    }];
    
    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-8);
        make.top.equalTo(self).offset(20);
    }];
}

#pragma mark - button event -
- (void)clickSettingButton:(UIButton *)button{
    
}

#pragma mark - lazy - 
- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"v2_my_avatar"]];
        _iconView.layer.cornerRadius = IconViewHW / 2;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel labelWithtextColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15] text:@"18815283156"];
    }
    return _nameLabel;
}

- (UIButton *)settingButton{
    if (_settingButton == nil) {
        _settingButton = [UIButton buttonWithTarget:self action:@selector(clickSettingButton:) image:@"v2_my_settings_icon" borderColor:[UIColor clearColor]];
    }
    return _settingButton;
}

- (UIImageView *)backgroundView{
    if (_backgroundView == nil) {
        _backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"v2_my_avatar_bg"]];
    }
    return _backgroundView;
}
@end
