//
//  XSYLoveBeenDetailPageHeaderView.m
//  LoveBeen
//
//  Created by xin on 2017/2/20.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenDetailPageHeaderView.h"
#import <UIImageView+WebCache.h>
#import "XSYLoveBeenFirstPageBottomShoppingModel.h"

@interface XSYLoveBeenDetailPageHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet UILabel *specificsLabel;

@end

@implementation XSYLoveBeenDetailPageHeaderView

+ (instancetype)DetailPageHeaderView{
    XSYLoveBeenDetailPageHeaderView *view =[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    return view;
}

- (void)setBottomModel:(XSYLoveBeenFirstPageBottomShoppingModel *)bottomModel{
    _bottomModel = bottomModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:bottomModel.img] placeholderImage:[UIImage imageNamed:@"doge"]];
    self.nameLabel.text = bottomModel.name;
    self.priceLabel.text = bottomModel.partner_price;
    self.marketPriceLabel.text = bottomModel.market_price;
    self.discountLabel.text = bottomModel.pm_desc;
    self.brandLabel.text = bottomModel.brand_name;
    self.specificsLabel.text = bottomModel.specifics;
}
@end
