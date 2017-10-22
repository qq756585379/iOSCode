//
//  TableSectionHeader.h
//  TZTV
//
//  Created by Luosa on 2016/11/11.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableSectionHeader : UITableViewHeaderFooterView

+(instancetype)tableHeaderWithTableView:(UITableView *)tv;
/**
 *  功能:获取cell的唯一标识符
 */
+ (NSString *)cellReuseIdentifier;
/**
 *	功能:cell根据数据显示ui
 */
- (void)updateWithCellData:(id)aData;
/**
 *	功能:获取cell的高度
 */
+ (CGFloat)heightForCellData:(id)aData;

@end
