//
//  XSYLoveBeenMarketLeftCell.m
//  LoveBeen
//
//  Created by xin on 2017/2/22.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenMarketLeftCell.h"
#import <Masonry.h>
#import "UIButton+Helper.h"
#import "UILabel+Helper.h"
#import "XSYLoveBeenCategoriesModel.h"

@interface XSYLoveBeenMarketLeftCell ()
@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UIView *leftLineView;
@end

@implementation XSYLoveBeenMarketLeftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.leftLineView];
        [self.contentView addSubview:self.centerLabel];
        [self addConstraint];
    }
    return self;
}

#pragma mark - addConstraint -
- (void)addConstraint{
    [self.leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(self.contentView).multipliedBy(0.8);
        make.width.equalTo(@(3));
    }];
    
    [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}

#pragma mark - set method -
- (void)setCategoriesModel:(XSYLoveBeenCategoriesModel *)categoriesModel{
    _categoriesModel = categoriesModel;
    self.centerLabel.text = categoriesModel.name;
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    self.centerLabel.textColor = isSelected ? [UIColor blackColor] : [UIColor lightGrayColor];
    self.leftLineView.hidden = !isSelected;
}

#pragma mark - lazy -
- (UILabel *)centerLabel{
    if (_centerLabel == nil) {
        _centerLabel = [UILabel labelWithtextColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:15]];
    }
    return _centerLabel;
}

- (UIView *)leftLineView{
    if (_leftLineView == nil) {
        _leftLineView = [[UIView alloc] init];
        _leftLineView.backgroundColor = mainColor;
        _leftLineView.hidden = YES;
    }
    return _leftLineView;
}
@end
