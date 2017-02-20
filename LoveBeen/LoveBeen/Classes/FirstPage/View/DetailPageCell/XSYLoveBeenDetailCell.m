//
//  XSYLoveBeenDetailCell.m
//  LoveBeen
//
//  Created by xin on 2017/2/20.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenDetailCell.h"
#import <Masonry.h>

@implementation XSYLoveBeenDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImage *backImage = [UIImage imageNamed:@"aaaa"];
        CGFloat W = ScreenWidth;
        CGFloat H = W * backImage.size.height / backImage.size.width;
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = backImage;
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(W, H));
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}
@end
