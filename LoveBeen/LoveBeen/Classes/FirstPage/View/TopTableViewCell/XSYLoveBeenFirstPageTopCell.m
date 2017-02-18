//
//  XSYLoveBeenFirstPageTopCell.m
//  LoveBeen
//
//  Created by xin on 2017/2/18.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenFirstPageTopCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "XSYLoveBeenActivityAndIconModel.h"

@interface XSYLoveBeenFirstPageTopCell ()
@property (nonatomic, strong) UIImageView *backgroundIconView;
@end

@implementation XSYLoveBeenFirstPageTopCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundIconView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.backgroundIconView];
        [self.backgroundIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setActivityModel:(XSYLoveBeenActivityAndIconModel *)activityModel{
    _activityModel = activityModel;
    NSURL *imgUrl = [NSURL URLWithString:activityModel.img];
    [self.backgroundIconView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"doge"]];
}
@end
