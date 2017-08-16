//
//  NSString+util.h
//  Common
//
//  Created by 杨俊 on 2017/7/21.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (util)

- (NSUInteger)byteCount;
/**
 *  NSString转为NSNumber
 */
- (NSNumber *)toNumber;

- (NSString *)urlEncoding;

- (NSString *)urlDecoding;

/**
 *  url encoding所有字符
 */
- (NSString *)urlEncodingAllCharacter;
/**
 *  功能:html语句居中处理
 */
- (NSString *)makeHtmlAlignCenter;
/**
 *  功能:拼装2个组合字串(知道首字串长度)
 */
- (NSAttributedString *)attributedStringWithHeadAttributes:(NSDictionary *)aAttributes
                                            tailAttributes:(NSDictionary *)bAttributes
                                                headLength:(NSUInteger)aLength;

/**
 *  功能:拼装2个组合字串(知道尾字串长度)
 */
- (NSAttributedString *)attributedStringWithHeadAttributes:(NSDictionary *)aAttributes
                                            tailAttributes:(NSDictionary *)bAttributes
                                                tailLength:(NSUInteger)aLength;

/**
 *  功能:拼装3个组合字串(知道首尾长度)
 */
- (NSAttributedString *)attributedStringWithHeadAttributes:(NSDictionary *)aAttributes
                                             midAttributes:(NSDictionary *)bAttributes
                                            tailAttributes:(NSDictionary *)cAttributes
                                                headLength:(NSUInteger)aLength
                                                tailLength:(NSUInteger)cLength;

/**
 *  替换字符串中指定的内容
 *
 *  @param fromAry    扫描字符串
 *  @param replaceAry 用于替换的字符串
 *
 *  @return 返回的结果
 */
- (NSString *)replaceFromArray:(NSArray *)fromAry withArray:(NSArray *)replaceAry;

/**
 *  功能:版本号比较
 */
- (NSComparisonResult)versionCompare:(NSString *)aString;

//计算一段字符串的长度，两个英文字符占一个长度。
+ (int)countTheStrLength:(NSString *)strtemp;

//是否是纯int
- (BOOL)isPureInt;
/**
 *  功能:是否浮点型
 */
- (BOOL)isPureFloat;
/**
 *  功能:让一段字符串文本和数字的颜色
 */
-(NSMutableAttributedString *)stringWithNumColor:(UIColor *)numColor
                                   andOtherColor:(UIColor *)color
                                     contentFont:(UIFont *)font;
/**
 *  功能:价格字符串小数点前后字体和颜色
 */
- (NSMutableAttributedString *)stringWithColor:(UIColor *)aColor
                                    symbolFont:(UIFont *)aSymbolFont
                                   integerFont:(UIFont *)aIntrgerFont
                                   decimalFont:(UIFont *)aDecimalFont;
/**
 *  功能:获取倒计时字符串
 */
+ (NSMutableAttributedString *)getTimeStringWithDateComponent:(NSDateComponents *)dateComponents
                                                      numFont:(UIFont *)numFont
                                                     numColor:(UIColor *)numColor
                                                characterFont:(UIFont *)charaterFont
                                               characterColor:(UIColor *)characterColor;

@end
