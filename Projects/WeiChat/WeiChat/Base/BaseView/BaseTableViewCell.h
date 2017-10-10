//
//  BaseTableViewCell.h
//  WeiChat
//
//  Created by 杨俊 on 2017/10/10.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSTableViewCell.h"

typedef NS_ENUM(NSInteger,CellLineStyle) {
    CellLineStyleDefault,
    CellLineStyleFill,
    CellLineStyleNone
};

@interface BaseTableViewCell : OTSTableViewCell

@property (nonatomic, assign) CellLineStyle bottomLineStyle;

@property (nonatomic, assign) CellLineStyle topLineStyle;

@property (nonatomic, assign) CGFloat leftFreeSpace; // 低线的左边距

@property (nonatomic, assign) CGFloat rightFreeSpace;

@property (nonatomic,   weak) UIView *bottomLine;

@property (nonatomic,   weak) UIView *topLine;

@end
