//
//  HQCommonCell.m
//  ListenToThis
//
//  Created by zhq on 15/10/4.
//  Copyright © 2015年 zhq. All rights reserved.
//

#import "HQCommonCell.h"
#import "UIImage+Extension.h"
#import "HQCommonItem.h"
#import "HQCommonItemArrowItem.h"
#import "HQCommonItemSwitchItem.h"
#import "HQCommonItemLabelItem.h"
#import "HQConst.h"
#import "NSString+Extension.h"
#import "UIView+Extension.h"
@interface HQCommonCell()
/**
 *  箭头
 */
@property (strong, nonatomic) UIImageView *rightArrow;
/**
 *  开关
 */
@property (strong, nonatomic) UISwitch *rightSwitch;
/**
 *  标签
 */
@property (strong, nonatomic) UILabel *rightLabel;
@end

@implementation HQCommonCell
#pragma mark - 懒加载右边的view
- (UIImageView *)rightArrow
{
    if (_rightArrow == nil) {
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_go"]];
    }
    return _rightArrow;
}

- (UISwitch *)rightSwitch
{
    if (_rightSwitch == nil) {
        _rightSwitch = [[UISwitch alloc] init];
        [_rightSwitch addTarget:self action:@selector(switchStateChange) forControlEvents:UIControlEventValueChanged];
    }
    return _rightSwitch;
}

- (UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        self.rightLabel = [[UILabel alloc] init];
        self.rightLabel.textColor = [UIColor lightGrayColor];
        self.rightLabel.font = [UIFont systemFontOfSize:13];
    }
    return _rightLabel;
}

// 监听开关状态改变
- (void)switchStateChange
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.rightSwitch.isOn forKey:self.item.title];
    [defaults synchronize];
    
    if ([self.item.title isEqualToString:settingNonePicture]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:noPictureNotification object:nil];
    }
}

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"common";
    HQCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HQCommonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:11];
        
        // 去除cell的默认背景色
        self.backgroundColor = [UIColor clearColor];
        
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage resizedImage:@"common_card_bottom_background"]];
    }
    return self;
}

- (void)setItem:(HQCommonItem *)item
{
    _item = item;
    
    // 1.设置基本数据
    if (item.icon) {
        self.imageView.image = [UIImage imageNamed:item.icon];
    }
    
    self.textLabel.text = item.title;

    // 2.设置右边的内容
    if ([item isKindOfClass:[HQCommonItemArrowItem class]]) {
        self.accessoryView = self.rightArrow;
    } else if ([item isKindOfClass:[HQCommonItemSwitchItem class]]) {
        self.accessoryView = self.rightSwitch;
        // 设置开关状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.rightSwitch.on = [defaults boolForKey:self.item.title];
        
    }else if ([item isKindOfClass:[HQCommonItemLabelItem class]]) {
        HQCommonItemLabelItem *labelItem = (HQCommonItemLabelItem *)item;
        // 设置文字
        self.rightLabel.text = labelItem.text;
        // 根据文字计算尺寸
        self.rightLabel.size = [labelItem.text sizeWithFont:self.rightLabel.font];
        self.accessoryView = self.rightLabel;
    }else { // 取消右边的内容
        self.accessoryView = nil;
    }
}


@end
