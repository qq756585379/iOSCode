//
//  PadListProductPinYin.h
//  OneStorePad
//
//  Created by jiangao on 15-3-30.
//  Copyright (c) 2015年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTSPinYin : NSObject
/**
 *  获取首字母
 *
 *  @param fullString 原字符串
 *
 *  @return 首字母
 */
+ (NSString *)getFirstLetter:(NSString *)fullString;

/*
 
 汉子转拼音
 chinese ： 汉子字符串
 
 */
+ (NSString *)chineseConvertEnglish:(NSString *)chinese;
@end
