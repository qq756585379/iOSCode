//
//  OTSTableViewHeaderFooterView.h
//  OneStoreFramework
//
//  Created by Aimy on 9/26/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTSTableViewHeaderFooterView : UITableViewHeaderFooterView
/**
 *  代理
 */
@property (nonatomic, weak) id delegate;

/**
 *  缩进边界
 */
@property (nonatomic) UIEdgeInsets cellEdgeInsets;

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
