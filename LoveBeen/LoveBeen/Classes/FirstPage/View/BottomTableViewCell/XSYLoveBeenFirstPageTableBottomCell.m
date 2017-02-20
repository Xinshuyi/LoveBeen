//
//  XSYLoveBeenFirstPageTableBottomCell.m
//  LoveBeen
//
//  Created by xin on 2017/2/19.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenFirstPageTableBottomCell.h"
#import <UIImageView+WebCache.h>
#import "XSYLoveBeenFirstPageBottomShoppingModel.h"
#import "CZAdditions.h"
#import <SVProgressHUD.h>

@interface XSYLoveBeenFirstPageTableBottomCell ()
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftDiscountLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftContainerLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftNowPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftMarketPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftSelectedLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftIncreaseButton;
@property (weak, nonatomic) IBOutlet UIButton *leftDecreaseButton;
@property (weak, nonatomic) IBOutlet UILabel *leftNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftShadowView;
@property (weak, nonatomic) IBOutlet UIView *leftBackgroundView;


@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *rightTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightDiscountLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightContainerLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightNowPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightMarketPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightSelectedLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightDecreaseButton;
@property (weak, nonatomic) IBOutlet UIButton *rightIncreaseButton;
@property (weak, nonatomic) IBOutlet UILabel *rightNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightShadowView;
@property (weak, nonatomic) IBOutlet UIView *rightBackgroundView;

@end

@implementation XSYLoveBeenFirstPageTableBottomCell

#pragma mark - initial -
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.leftSelectedLabel.layer.borderWidth = 1;
    self.leftSelectedLabel.layer.borderColor = [UIColor redColor].CGColor;
    self.rightSelectedLabel.layer.borderWidth = 1;
    self.rightSelectedLabel.layer.borderColor = [UIColor redColor].CGColor;
    
    // 给左右内容增加手势
    // 左
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTapAction:)];
    self.leftImageView.userInteractionEnabled = YES;
    [self.leftImageView addGestureRecognizer:leftTap];
    
    // 右
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTapAction:)];
    self.rightImageView.userInteractionEnabled = YES;
    [self.rightImageView addGestureRecognizer:rightTap];
}

#pragma mark - set method -
- (void)setLeftModel:(XSYLoveBeenFirstPageBottomShoppingModel *)leftModel{
    _leftModel = leftModel;
    
    // 防止加减号的hidden状态复用
    self.leftDecreaseButton.hidden = leftModel.isDecreaseButtonHidden;
    self.leftIncreaseButton.hidden = leftModel.isIncreaseButtonHidden;
    
    self.leftShadowView.hidden = leftModel.number;
    
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:leftModel.img] placeholderImage:[UIImage imageNamed:@"doge"]];
    self.leftDiscountLabel.text = leftModel.pm_desc;
    self.leftTitleLabel.text = leftModel.name;
    self.leftContainerLabel.text = leftModel.specifics;
    self.leftNowPriceLabel.text = leftModel.partner_price;
    self.leftMarketPriceLabel.attributedText = [self addStrikeLineWithString:leftModel.market_price];
    // 防止商品数复用
    self.leftNumLabel.text = [NSString stringWithFormat:@"%02ld",leftModel.numOfShopsInShoppingCar];
}

- (void)setRightModel:(XSYLoveBeenFirstPageBottomShoppingModel *)rightModel{
    _rightModel = rightModel;
    
    // 防止加减号的hidden状态复用
    self.rightDecreaseButton.hidden = rightModel.isDecreaseButtonHidden;
    self.rightIncreaseButton.hidden = rightModel.isIncreaseButtonHidden;
    
    self.rightShadowView.hidden = rightModel.number;
    
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:rightModel.img] placeholderImage:[UIImage imageNamed:@"doge"]];
    self.rightDiscountLabel.text = rightModel.pm_desc;
    self.rightTitleLabel.text = rightModel.name;
    self.rightContainerLabel.text = rightModel.specifics;
    self.rightNowPriceLabel.text = rightModel.partner_price;
    self.rightMarketPriceLabel.attributedText = [self addStrikeLineWithString:rightModel.market_price];
    // 防止商品数量复用
    self.rightNumLabel.text = [NSString stringWithFormat:@"%02ld",rightModel.numOfShopsInShoppingCar];
}

#pragma mark - attributedstring -
// 返回删除线属性字符串
- (NSMutableAttributedString *)addStrikeLineWithString:(NSString *)string{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    [str addAttribute:NSStrikethroughStyleAttributeName value:
     [NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, string.length)]; // 删除线类型
    [str addAttribute:NSStrikethroughColorAttributeName value:
     [UIColor cz_colorWithRed:148 green:148 blue:148] range:NSMakeRange(0, string.length)]; // 删除线颜色
    return str;
}

#pragma mark - button events -
// left
- (IBAction)clickLeftDecreaseButton:(UIButton *)sender {
    self.leftIncreaseButton.hidden = NO;
    
    self.leftModel.numOfShopsInShoppingCar --;
    self.leftDecreaseButton.hidden = !self.leftModel.numOfShopsInShoppingCar;
    self.leftNumLabel.text = [NSString stringWithFormat:@"%02ld",self.leftModel.numOfShopsInShoppingCar];
    // 防止复用
    [self setIncreaseButtonIsHidden:self.leftIncreaseButton.hidden andSetDecreaseButtonIsHidden:self.leftDecreaseButton.hidden withModel:_leftModel];
    [self sendDataWithDelegateWithButton:sender Model:_leftModel isLeft:YES isIncrease:NO];
}
- (IBAction)clickLeftIncreaseButton:(UIButton *)sender {
    self.leftDecreaseButton.hidden = NO;
    
    if (self.leftModel.numOfShopsInShoppingCar + 1 > _leftModel.number) {
        self.leftIncreaseButton.hidden = YES;
        [self showNotEnoughShopsHUD];
        return;
    }
    self.leftModel.numOfShopsInShoppingCar ++ ;
    self.leftNumLabel.text = [NSString stringWithFormat:@"%02ld",self.leftModel.numOfShopsInShoppingCar];
    // 防止复用
    [self setIncreaseButtonIsHidden:self.leftIncreaseButton.hidden andSetDecreaseButtonIsHidden:self.leftDecreaseButton.hidden withModel:_leftModel];
    [self sendDataWithDelegateWithButton:sender Model:_leftModel isLeft:YES isIncrease:YES];
}

# pragma mark - tap events -
- (void)leftTapAction:(UITapGestureRecognizer *)leftTap{
    [self sendDataByDelegateWithIsLeft:YES bottomModel:_leftModel];
}

- (void)rightTapAction:(UITapGestureRecognizer *)rightTap{
    [self sendDataByDelegateWithIsLeft:NO bottomModel:_rightModel];
}

// right
- (IBAction)clickRightDecreaseButton:(UIButton *)sender {
    self.rightIncreaseButton.hidden = NO;
    
    self.rightModel.numOfShopsInShoppingCar --;
    self.rightDecreaseButton.hidden = !self.rightModel.numOfShopsInShoppingCar;
    self.rightNumLabel.text = [NSString stringWithFormat:@"%02ld",self.rightModel.numOfShopsInShoppingCar];
    
      [self setIncreaseButtonIsHidden:self.rightIncreaseButton.hidden andSetDecreaseButtonIsHidden:self.rightDecreaseButton.hidden withModel:_rightModel];
    [self sendDataWithDelegateWithButton:sender Model:_rightModel isLeft:NO isIncrease:NO];
}

- (IBAction)clickRightIncreaseButton:(UIButton *)sender {
    self.rightDecreaseButton.hidden = NO;
    
    if (self.rightModel.numOfShopsInShoppingCar + 1 > _rightModel.number) {
        self.rightIncreaseButton.hidden = YES;
        [self showNotEnoughShopsHUD];
        return;
    }
    self.rightModel.numOfShopsInShoppingCar ++ ;
    self.rightNumLabel.text = [NSString stringWithFormat:@"%02ld",self.rightModel.numOfShopsInShoppingCar];
    
     [self setIncreaseButtonIsHidden:self.rightIncreaseButton.hidden andSetDecreaseButtonIsHidden:self.rightDecreaseButton.hidden withModel:_rightModel];
    [self sendDataWithDelegateWithButton:sender Model:_rightModel isLeft:NO isIncrease:YES];
}

#pragma mark - other method -

// 库存已满的hud
- (void)showNotEnoughShopsHUD{
    [SVProgressHUD showErrorWithStatus:@"库存不足"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

// 代理传值 矫正cell的复用
- (void)sendDataWithDelegateWithButton:(UIButton *)button Model:(XSYLoveBeenFirstPageBottomShoppingModel *)model isLeft:(BOOL)isLeft isIncrease:(BOOL)isIncrease{
    if ([self.delegate respondsToSelector:@selector(tableBottomCell:didClickIncreaseOrDecreaseButton:isIncrease:isLeft:)]) {
        [self.delegate tableBottomCell:self didClickIncreaseOrDecreaseButton:button isIncrease:isIncrease isLeft:isLeft];
    }
}

// 代理传值提示控制器跳转detail控制器
- (void)sendDataByDelegateWithIsLeft:(BOOL)isLeft bottomModel:(XSYLoveBeenFirstPageBottomShoppingModel *)bottomModel{
    if ([self.delegate respondsToSelector:@selector(tableBottomCell:didClickDetailControllerWithIsLeft:bottomModel:)]) {
        [self.delegate tableBottomCell:self didClickDetailControllerWithIsLeft:isLeft bottomModel:bottomModel];
    }
}

- (void)setIncreaseButtonIsHidden:(BOOL)isInCreaseHidden andSetDecreaseButtonIsHidden:(BOOL)isDecreaseHidden withModel:(XSYLoveBeenFirstPageBottomShoppingModel *)model{
    model.isIncreaseButtonHidden = isInCreaseHidden;
    model.isDecreaseButtonHidden = isDecreaseHidden;
}
@end
