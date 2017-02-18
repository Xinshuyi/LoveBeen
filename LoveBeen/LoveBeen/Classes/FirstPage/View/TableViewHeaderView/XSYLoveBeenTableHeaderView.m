//
//  XSYLoveBeenTableHeaderView.m
//  LoveBeen
//
//  Created by xin on 2017/2/18.
//  Copyright © 2017年 DogeEggEgg. All rights reserved.
//

#import "XSYLoveBeenTableHeaderView.h"
#import <SDCycleScrollView.h>
#import <Masonry.h>
#import "UILabel+Helper.h"
#import "UIButton+Helper.h"
#import "CZAdditions.h"
#import "XSYLoveBeenFirstPageModel.h"
#import "XSYLoveBeenActivityAndIconModel.h"
#import "XSYLoveBeenFocusModel.h"
#import <UIButton+WebCache.h>

#define cycleViewHeight self.bounds.size.height * 0.65
#define buttonHeight self.bounds.size.height * 0.35 * 0.6
#define labelViewHeight self.bounds.size.height * 0.35 * 0.4
#define eachWidth ScreenWidth / self.topMainModel.icons.count

@interface XSYLoveBeenTableHeaderView ()
@property (nonatomic, strong) SDCycleScrollView *cycleView;
@property (nonatomic, strong) NSMutableArray<UIButton *> *buttonArray;
@property (nonatomic, strong) NSMutableArray<UILabel *> *labelArray;
@property (nonatomic, strong) XSYLoveBeenFirstPageModel *topMainModel;
@end

@implementation XSYLoveBeenTableHeaderView
- (instancetype)initWithFrame:(CGRect)frame andTopMainModel:(XSYLoveBeenFirstPageModel *)topMainModel{
    if (self = [super initWithFrame: frame]) {
        
        self.topMainModel = topMainModel;
        
        [self initialCycleView];
        
        [self initialButtonArray];
        
        [self initialLabelArray];
    }
    return self;
}

- (void)clickButtons:(UIButton *)button{
    
}

#pragma mark - 设置子控件 -

- (void)initialCycleView{
    NSMutableArray *imgArray = [NSMutableArray array];
    for (int i = 0; i < self.topMainModel.focus.count; i ++ ) {
        NSURL *url = [NSURL URLWithString:self.topMainModel.focus[i].img];
        [imgArray addObject:url];
    }
    _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, cycleViewHeight) imageURLStringsGroup:imgArray];
    _cycleView.showPageControl = YES;
    _cycleView.currentPageDotColor = mainColor;
    [self addSubview:_cycleView];
}

- (void)initialButtonArray{
    _buttonArray = [NSMutableArray array];
    for (int i = 0; i < self.topMainModel.icons.count; i ++) {
        
        NSURL *img = [NSURL URLWithString: self.topMainModel.icons[i].img];
        UIButton *button = [UIButton buttonWithTarget:self action:@selector(clickButtons:) image:nil];
        [button sd_setImageWithURL:img forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"doge"]];
        button.tag = i;
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button.frame = CGRectMake(i * eachWidth, cycleViewHeight, eachWidth, buttonHeight);
        [self addSubview:button];
        [_buttonArray addObject:button];
    }
}

- (void)initialLabelArray{
    for (int i = 0; i < self.topMainModel.icons.count; i ++) {
        NSString *title = self.topMainModel.icons[i].name;
        UILabel *label = [UILabel labelWithtextColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] text:title];
        label.tag = i;
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(i * eachWidth, buttonHeight + cycleViewHeight, eachWidth, labelViewHeight);
        [self addSubview:label];
        [_labelArray addObject:label];
    }
}

@end
