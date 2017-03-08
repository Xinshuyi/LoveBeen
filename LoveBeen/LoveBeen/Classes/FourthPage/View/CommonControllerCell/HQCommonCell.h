//
//  HQCommonCell.h
//  ListenToThis
//
//  Created by zhq on 15/10/4.
//  Copyright © 2015年 zhq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HQCommonItem;
@interface HQCommonCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
//- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows;

/** cell对应的item数据 */
@property (nonatomic, strong) HQCommonItem *item;
@end
