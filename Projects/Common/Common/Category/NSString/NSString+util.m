//
//  NSString+util.m
//  Common
//
//  Created by 杨俊 on 2017/7/21.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "NSString+util.h"
#import "NSString+safe.h"
#import "NSArray+safe.h"

@implementation NSString (util)

- (NSUInteger)byteCount{
    NSUInteger length = 0;
    char *pStr = (char *)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0 ; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*pStr) {
            pStr++;
            length++;
        }else {
            pStr++;
        }
    }
    return length;
}

- (NSNumber *)toNumber{
    NSNumberFormatter *formatter=[[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *number=[formatter numberFromString:self];
    return number;
}

- (NSString *)urlEncoding{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString *)urlDecoding{
    return self.stringByRemovingPercentEncoding;
}

- (NSString *)urlEncodingAllCharacter{
    NSString *outputStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)self,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    return outputStr;
}

/**
 *  功能:html语句居中处理
 */
- (NSString *)makeHtmlAlignCenter{
    return  [NSString stringWithFormat:@"<head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/><meta name=viewport content=width=device-width, user-scalable=yes ><style type=\"text/css\">body{text-align:center;}div{width:750px;margin:10 auto;text-align:left;}</style></head><body><div>%@</div></body>",self];
}

/**
 *  功能:拼装2个组合字串(知道首字串长度)
 */
- (NSAttributedString *)attributedStringWithHeadAttributes:(NSDictionary *)aAttributes
                                            tailAttributes:(NSDictionary *)bAttributes
                                                headLength:(NSUInteger)aLength{
    NSRange headRange = NSMakeRange(0, aLength);
    NSRange tailRange = NSMakeRange(aLength, self.length-aLength);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    [attributedString setAttributes:aAttributes range:headRange];
    [attributedString setAttributes:bAttributes range:tailRange];
    return attributedString;
}

/**
 *  功能:拼装2个组合字串(知道尾字串长度)
 */
- (NSAttributedString *)attributedStringWithHeadAttributes:(NSDictionary *)aAttributes
                                            tailAttributes:(NSDictionary *)bAttributes
                                                tailLength:(NSUInteger)aLength{
    NSRange headRange = NSMakeRange(0, self.length-aLength);
    NSRange tailRange = NSMakeRange(self.length-aLength, aLength);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    [attributedString setAttributes:aAttributes range:headRange];
    [attributedString setAttributes:bAttributes range:tailRange];
    
    return attributedString;
}

/**
 *  功能:拼装3个组合字串(知道首尾长度)
 */
- (NSAttributedString *)attributedStringWithHeadAttributes:(NSDictionary *)aAttributes
                                             midAttributes:(NSDictionary *)bAttributes
                                            tailAttributes:(NSDictionary *)cAttributes
                                                headLength:(NSUInteger)aLength
                                                tailLength:(NSUInteger)cLength{
    NSRange headRange = NSMakeRange(0, aLength);
    NSRange midRange = NSMakeRange(aLength, self.length-aLength-cLength);
    NSRange tailRange = NSMakeRange(self.length-cLength, cLength);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    [attributedString setAttributes:aAttributes range:headRange];
    [attributedString setAttributes:bAttributes range:midRange];
    [attributedString setAttributes:cAttributes range:tailRange];
    return attributedString;
}

/**
 *  替换字符串中指定的内容
 *
 *  @param fromAry    扫描字符串
 *  @param replaceAry 用于替换的字符串
 *
 *  @return 返回的结果
 */
- (NSString *)replaceFromArray:(NSArray *)fromAry withArray:(NSArray *)replaceAry{
    NSString *result = [NSString stringWithString:self];
    if (result.length>0 && [fromAry count]>0 &&([fromAry count] == [replaceAry count])) {
        for (int i =0;i< [fromAry count];i ++) {
            id fromStr = [fromAry objectAtIndex:i];
            id replaceStr = [replaceAry objectAtIndex:i];
            if ([fromStr isKindOfClass:[NSString class]] && [replaceStr isKindOfClass:[NSString class]]) {
                result = [result stringByReplacingOccurrencesOfString:fromStr withString:replaceStr];
            }else{
                return self;
            }
        }
    }
    return result;
}

/**
 *  功能:版本号比较
 */
- (NSComparisonResult)versionCompare:(NSString *)aString{
    NSArray *selfComponents = [self componentsSeparatedByString:@"."];
    NSArray *aComponents = [aString componentsSeparatedByString:@"."];
    NSUInteger maxCount = MAX(selfComponents.count, aComponents.count);
    for (NSUInteger i=0; i<maxCount; i++) {
        NSString *selfComponent = [selfComponents safeObjectAtIndex:i];
        if (selfComponent == nil) {
            selfComponent = @"0";
        }
        NSString *aComponent = [aComponents safeObjectAtIndex:i];
        if (aComponent == nil) {
            aComponent = @"0";
        }
        NSComparisonResult result = [selfComponent compare:aComponent];
        if (result == NSOrderedSame) {
            continue;
        } else {
            return result;
        }
    }
    return NSOrderedSame;
}

//计算一段字符串的长度，两个英文字符占一个长度。
+ (int)countTheStrLength:(NSString *)strtemp{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}

//是否是纯int
- (BOOL)isPureInt{
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
/**
 *  功能:让一段字符串文本和数字的颜色
 */
-(NSMutableAttributedString *)stringWithNumColor:(UIColor *)numColor andOtherColor:(UIColor *)color contentFont:(UIFont *)font{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^0-9]" options:0 error:nil];
    NSArray *numArr = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSForegroundColorAttributeName:numColor}];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,[self length])];
    for (NSTextCheckingResult *attirbute in numArr) {
        [attributedString setAttributes:@{NSForegroundColorAttributeName:color} range:attirbute.range];
    }
    return attributedString;
}

/**
 *  功能:价格字符串小数点前后字体和颜色
 */
- (NSMutableAttributedString *)stringWithColor:(UIColor *)aColor symbolFont:(UIFont *)aSymbolFont integerFont:(UIFont *)aIntrgerFont decimalFont:(UIFont *)aDecimalFont {
    if (self.length <= 0) {
        return nil;
    }
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self];
    [string addAttribute:NSForegroundColorAttributeName value:aColor range:NSMakeRange(0, string.length)];
    [string addAttribute:NSFontAttributeName value:aSymbolFont range:NSMakeRange(0, 1)];
    NSRange range = [self rangeOfString:@"."];
    if (range.location != NSNotFound) {
        [string addAttribute:NSFontAttributeName value:aIntrgerFont range:NSMakeRange(1, range.location)];
        [string addAttribute:NSFontAttributeName value:aDecimalFont range:NSMakeRange(range.location,  string.length - range.location)];
    } else {
        [string addAttribute:NSFontAttributeName value:aIntrgerFont range:NSMakeRange(1, string.length - 1)];
    }
    
    return string;
}

/**
 *  功能:是否浮点型
 */
- (BOOL)isPureFloat {
    NSScanner *scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

/**
 *  功能:获取倒计时字符串
 */
+ (NSMutableAttributedString *)getTimeStringWithDateComponent:(NSDateComponents *)dateComponents numFont:(UIFont *)numFont numColor:(UIColor *)numColor characterFont:(UIFont *)charaterFont characterColor:(UIColor *)characterColor{
    int totalHour = abs((int)dateComponents.hour);
    int day = totalHour/24;
    int hour = totalHour%24;
    int minute = abs((int)dateComponents.minute);
    int second = abs((int)dateComponents.second);
    NSDictionary *dateDict = @{NSForegroundColorAttributeName:numColor,NSFontAttributeName:numFont};
    NSDictionary *characterDict = @{NSForegroundColorAttributeName:characterColor,NSFontAttributeName:charaterFont};
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    NSString *dayString  = [NSString stringWithFormat:@"%02d天", day];
    NSMutableAttributedString *dayAttrString = [[NSMutableAttributedString alloc] initWithString:dayString];
    [dayAttrString addAttributes:dateDict range:NSMakeRange(0, 2)];
    [dayAttrString addAttributes:characterDict range:NSMakeRange(2, 1)];
    
    NSString *hourString = [NSString stringWithFormat:@"%02d小时", hour];
    NSMutableAttributedString *hourAttrString = [[NSMutableAttributedString alloc] initWithString:hourString];
    [hourAttrString addAttributes:dateDict range:NSMakeRange(0, 2)];
    [hourAttrString addAttributes:characterDict range:NSMakeRange(2, 2)];
    
    NSString *minuteString = [NSString stringWithFormat:@"%02d分", minute];
    NSMutableAttributedString *minuteAttrString = [[NSMutableAttributedString alloc] initWithString:minuteString];
    [minuteAttrString addAttributes:dateDict range:NSMakeRange(0, 2)];
    [minuteAttrString addAttributes:characterDict range:NSMakeRange(2, 1)];
    
    NSString *secondString = [NSString stringWithFormat:@"%02d秒", second];
    NSMutableAttributedString *secondAttrString = [[NSMutableAttributedString alloc] initWithString:secondString];
    [secondAttrString addAttributes:dateDict range:NSMakeRange(0, 2)];
    [secondAttrString addAttributes:characterDict range:NSMakeRange(2, 1)];
    
    if (day > 0) {
        [attributedString appendAttributedString:dayAttrString];
        [attributedString appendAttributedString:hourAttrString];
        [attributedString appendAttributedString:minuteAttrString];
        [attributedString appendAttributedString:secondAttrString];
    } else if (hour > 0){
        [attributedString appendAttributedString:hourAttrString];
        [attributedString appendAttributedString:minuteAttrString];
        [attributedString appendAttributedString:secondAttrString];
    } else if (minute > 0){
        [attributedString appendAttributedString:minuteAttrString];
        [attributedString appendAttributedString:secondAttrString];
    } else if (second > 0){
        [attributedString appendAttributedString:secondAttrString];
    } else {
        NSString *timeString = @"0秒";
        attributedString = [[NSMutableAttributedString alloc] initWithString:timeString];
    }
    return attributedString;
}

@end
