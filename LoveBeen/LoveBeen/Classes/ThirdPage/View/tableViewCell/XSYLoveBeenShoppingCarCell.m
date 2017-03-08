//
//  XSYLoveBeenShoppingCarCell.m
//  LoveBeen
//
//  Created by xin on 2017/2/24.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenShoppingCarCell.h"
#import "XSYLoveBeenFirstPageBottomShoppingModel.h"
#import <SVProgressHUD.h>

@interface XSYLoveBeenShoppingCarCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIButton *decreaseButton;
@property (weak, nonatomic) IBOutlet UIButton *increaseButton;

@end

@implementation XSYLoveBeenShoppingCarCell

- (IBAction)clickDecreaseButton:(UIButton *)sender {
    self.increaseButton.hidden = NO;
    self.shoppingModel.isIncreaseButtonHidden = NO;
    
    self.shoppingModel.numOfShopsInShoppingCar -- ;
    sender.hidden = !self.shoppingModel.numOfShopsInShoppingCar;
    self.shoppingModel.isDecreaseButtonHidden = sender.hidden;
    self.numberLabel.text = [NSString stringWithFormat:@"%02ld",self.shoppingModel.numOfShopsInShoppingCar];
    
    [self sendDataByDelegateWithIsIncrease:NO];
}
- (IBAction)clickIncreaseButton:(UIButton *)sender {
    self.decreaseButton.hidden = NO;
    self.shoppingModel.isDecreaseButtonHidden = NO;
    
    if (self.shoppingModel.numOfShopsInShoppingCar + 1 > self.shoppingModel.number) {
        [SVProgressHUD showErrorWithStatus:@"库存不足"];
        sender.hidden = YES;
        self.shoppingModel.isIncreaseButtonHidden = YES;
        return;
    }
    self.shoppingModel.numOfShopsInShoppingCar ++;
    self.numberLabel.text = [NSString stringWithFormat:@"%02ld",self.shoppingModel.numOfShopsInShoppingCar];
    [self sendDataByDelegateWithIsIncrease:YES];
}

- (void)sendDataByDelegateWithIsIncrease:(BOOL)isIncrease{
    if ([self.delegate respondsToSelector:@selector(shoppingCarCell:didClickDecreaseButtonOrIncreaseIsIncrease:shoppingModel:)]) {
        [self.delegate shoppingCarCell:self didClickDecreaseButtonOrIncreaseIsIncrease:isIncrease shoppingModel:self.shoppingModel];
    }
}

- (void)setShoppingModel:(XSYLoveBeenFirstPageBottomShoppingModel *)shoppingModel{
    _shoppingModel = shoppingModel;
    self.nameLabel.text = shoppingModel.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",shoppingModel.partner_price];
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",shoppingModel.numOfShopsInShoppingCar];
    self.decreaseButton.hidden = shoppingModel.isDecreaseButtonHidden;
    self.increaseButton.hidden = shoppingModel.isIncreaseButtonHidden;
}
@end
