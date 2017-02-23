//
//  XSYLoveBeenMarketRightCell.m
//  LoveBeen
//
//  Created by xin on 2017/2/22.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenMarketRightCell.h"
#import "UILabel+Helper.h"
#import "UIButton+Helper.h"
#import "CZAdditions.h"
#import <UIImageView+WebCache.h>
#import "XSYLoveBeenFirstPageBottomShoppingModel.h"
#import <Masonry.h>

@interface XSYLoveBeenMarketRightCell ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIImageView *selectedView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *specificsLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *marketPriceLabel;
@property (strong, nonatomic) UIButton *increaseButton;
@property (strong, nonatomic) UIButton *decreaseButton;
@property (strong, nonatomic) UILabel *numLabel;
@end

@implementation XSYLoveBeenMarketRightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.selectedView];
        [self.contentView addSubview:self.titleLable];
        [self.contentView addSubview:self.specificsLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.marketPriceLabel];
        [self.contentView addSubview:self.decreaseButton];
        [self.contentView addSubview:self.numLabel];
        [self.contentView addSubview:self.increaseButton];
        [self addConstraints];
    }
    return self;
}

#pragma mark - click button events -
- (void)clickIncreaseButton:(UIButton *)button{
    
}

- (void)clickDecreaseButton:(UIButton *)button{
    
}

#pragma mark - addConstraints -
- (void)addConstraints{
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.width.equalTo(self.iconView.mas_height).multipliedBy(0.618);
    }];
    
    [self.selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView);
        make.leading.equalTo(self.iconView.mas_trailing).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 10));
    }];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.selectedView.mas_trailing).offset(2);
        make.centerY.equalTo(self.selectedView);
    }];
    
    [self.specificsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.selectedView);
        make.centerY.equalTo(self.iconView);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.specificsLabel);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    [self.marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.priceLabel.mas_trailing).offset(8);
        make.centerY.equalTo(self.priceLabel);
    }];
    
    [self.decreaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-75);
        make.centerY.equalTo(self.priceLabel);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.increaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.decreaseButton);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.increaseButton);
        make.leading.equalTo(self.decreaseButton.mas_trailing).offset(4);
        make.height.mas_equalTo(20);
    }];
}

#pragma mark - set method -
- (void)setShoppingModel:(XSYLoveBeenFirstPageBottomShoppingModel *)shoppingModel{
    _shoppingModel = shoppingModel;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:shoppingModel.img] placeholderImage:[UIImage imageNamed:@"doge"]];
    self.titleLable.text = shoppingModel.name;
    self.specificsLabel.text = shoppingModel.specifics;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",shoppingModel.partner_price];
    self.marketPriceLabel.attributedText = [self addStrikeLineWithString:[NSString stringWithFormat:@"￥%@",shoppingModel.market_price]];
}

// 返回删除线属性字符串
- (NSMutableAttributedString *)addStrikeLineWithString:(NSString *)string{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    [str addAttribute:NSStrikethroughStyleAttributeName value:
     [NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, string.length)]; // 删除线类型
    [str addAttribute:NSStrikethroughColorAttributeName value:
     [UIColor cz_colorWithRed:148 green:148 blue:148] range:NSMakeRange(0, string.length)]; // 删除线颜色
    return str;
}

#pragma mark - lazy -
- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        _iconView.clipsToBounds = YES;
    }
    return _iconView;
}

- (UIImageView *)selectedView{
    if (_selectedView == nil) {
        _selectedView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jingxuan.png"]];
    }
    return _selectedView;
}

- (UILabel *)titleLable{
    if (_titleLable == nil) {
        _titleLable = [UILabel labelWithtextColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13]];
    }
    return _titleLable;
}

- (UILabel *)specificsLabel{
    if (_specificsLabel == nil) {
        _specificsLabel = [UILabel labelWithtextColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:12]];
    }
    return _specificsLabel;
}

- (UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [UILabel labelWithtextColor:[UIColor cz_colorWithHex:0xEC5BAB] font:[UIFont systemFontOfSize:13]];
    }
    return _priceLabel;
}

- (UILabel *)marketPriceLabel{
    if (_marketPriceLabel == nil) {
        _marketPriceLabel = [UILabel labelWithtextColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:12]];
    }
    return _marketPriceLabel;
}

- (UIButton *)increaseButton{
    if (_increaseButton == nil) {
        _increaseButton = [UIButton buttonWithTarget:self action:@selector(clickIncreaseButton:) image:@"v2_increase"];
    }
    return _increaseButton;
}

- (UIButton *)decreaseButton{
    if (_decreaseButton == nil) {
        _decreaseButton = [UIButton buttonWithTarget:self action:@selector(clickDecreaseButton:) image:@"v2_reduce"];
    }
    return _decreaseButton;
}

- (UILabel *)numLabel{
    if (_numLabel == nil) {
        _numLabel = [UILabel labelWithtextColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] text:@"00"];
        _numLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numLabel;
}
@end
