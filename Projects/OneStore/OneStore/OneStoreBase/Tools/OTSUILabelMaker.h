//
//  OTSUILabelMaker.h
//  OneStoreFramework
//
//  Created by airspuer on 5/1/15.
//  Copyright (c) 2015 OneStore. All rights reserved.
//

#import "OTSViewMaker.h"

@interface OTSUILabelMaker : OTSViewMaker

@property(nonatomic, strong)UIColor *textColor;

/**
 *  UILabel的字体大小,默认的是[UIFont systemFontSize]
 */
@property(nonatomic, assign)CGFloat fontSize;

/**
 *  UILabel的行数，0表示支持多行，默认是1行
 */
@property(nonatomic) NSInteger numberOfLines;

@end
