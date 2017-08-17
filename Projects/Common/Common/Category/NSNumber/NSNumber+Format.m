//
//  NSNumber+Format.m
//  OneStoreFramework
//
//  Created by airspuer on 14-9-22.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "NSNumber+Format.h"
//category
#import "NSString+util.h"
#import "NSString+safe.h"

@implementation NSNumber(Format)

- (NSString *)moneyFormatString
{
    NSString *priceString = [NSString stringWithFormat:@"¥%.2f", self.floatValue];
    NSString *endChar = [priceString safeSubstringWithRange:NSMakeRange(priceString.length-1, 1)];
    if ([endChar isEqualToString:@"0"]) {
        priceString = [priceString safeSubstringWithRange:NSMakeRange(0, priceString.length-1)];
    }
    return priceString;
}

+ (NSString *)moneyFormat:(double)aValue
{
    NSString *priceString = [NSString stringWithFormat:@"¥%.2f", aValue];
    NSString *endChar = [priceString safeSubstringWithRange:NSMakeRange(priceString.length-1, 1)];
    if ([endChar isEqualToString:@"0"]) {
        priceString = [priceString safeSubstringWithRange:NSMakeRange(0, priceString.length-1)];
    }
    return priceString;
}

+ (NSString *)valueFormat:(double)aValue
{
    NSString *priceString = [NSString stringWithFormat:@"%.2f", aValue];
    NSString *endChar = [priceString safeSubstringWithRange:NSMakeRange(priceString.length-1, 1)];
    if ([endChar isEqualToString:@"0"]) {
        priceString = [priceString safeSubstringWithRange:NSMakeRange(0, priceString.length-1)];
        NSString *endChar = [priceString safeSubstringWithRange:NSMakeRange(priceString.length-1, 1)];
        if ([endChar isEqualToString:@"0"]) {
            priceString = [priceString safeSubstringWithRange:NSMakeRange(0, priceString.length-1)];
            NSString *endChar = [priceString safeSubstringWithRange:NSMakeRange(priceString.length-1, 1)];
            if ([endChar isEqualToString:@"."]) {
                priceString = [priceString safeSubstringWithRange:NSMakeRange(0, priceString.length-1)];
            }
        }
    }
    return priceString;
}


+ (NSString *)persentFormat:(double)aValue
{
    NSString *persentString = [NSString stringWithFormat:@"%.2f", aValue];
    NSString *endChar = [persentString safeSubstringWithRange:NSMakeRange(persentString.length-1, 1)];
    if ([endChar isEqualToString:@"0"]) {
        persentString = [persentString safeSubstringWithRange:NSMakeRange(0, persentString.length-1)];
        NSString *endChar = [persentString safeSubstringWithRange:NSMakeRange(persentString.length-1, 1)];
        if ([endChar isEqualToString:@"0"]) {
            persentString = [persentString safeSubstringWithRange:NSMakeRange(0, persentString.length-1)];
            NSString *endChar = [persentString safeSubstringWithRange:NSMakeRange(persentString.length-1, 1)];
            if ([endChar isEqualToString:@"."]) {
                persentString = [persentString safeSubstringWithRange:NSMakeRange(0, persentString.length-1)];
            }
        }
    }
    return [NSString stringWithFormat:@"%@%%", persentString];
}

+ (NSString *)weightFormat:(double)aValue
{
    NSString *priceString = [NSString stringWithFormat:@"%.3f", aValue];
    NSString *endChar = [priceString safeSubstringWithRange:NSMakeRange(priceString.length-1, 1)];
    if ([endChar isEqualToString:@"0"]) {
        priceString = [priceString safeSubstringWithRange:NSMakeRange(0, priceString.length-1)];
        NSString *endChar = [priceString safeSubstringWithRange:NSMakeRange(priceString.length-1, 1)];
        if ([endChar isEqualToString:@"0"]) {
            priceString = [priceString safeSubstringWithRange:NSMakeRange(0, priceString.length-1)];
            NSString *endChar = [priceString safeSubstringWithRange:NSMakeRange(priceString.length-1, 1)];
            if ([endChar isEqualToString:@"0"]) {
                priceString = [priceString safeSubstringWithRange:NSMakeRange(0, priceString.length-1)];
                NSString *endChar = [priceString safeSubstringWithRange:NSMakeRange(priceString.length-1, 1)];
                if ([endChar isEqualToString:@"."]) {
                    priceString = [priceString safeSubstringWithRange:NSMakeRange(0, priceString.length-1)];
                }
            }
        }
    }
    return priceString;
}

/**
 *  功能:价格积分(eg:¥99.9 + 10 积分) 或 (eg:¥99.9\n10 积分)
 */
+ (NSAttributedString *)attStringWithPrice:(CGFloat)aPrice
                                     point:(NSInteger)aPoint
                                  joinChar:(NSString *)aChar
                           priceAttributes:(NSDictionary *)aAttributes
                           pointAttributes:(NSDictionary *)bAttributes
                            charAttributes:(NSDictionary *)cAttributes
{
    if (aPoint <= 0) {
        NSString *compStr = [NSNumber moneyFormat:aPrice];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:compStr];
        [attributedString setAttributes:aAttributes range:NSMakeRange(0, compStr.length)];
        return attributedString;
    } else if (aPrice <= 0.0) {
        NSString *compStr = [NSString stringWithFormat:@"%zd 积分", aPoint];
        
        return [compStr attributedStringWithHeadAttributes:bAttributes tailAttributes:cAttributes tailLength:3];
    } else {
        NSString *compStr = [NSString stringWithFormat:@"%@%@%zd 积分", [NSNumber moneyFormat:aPrice], aChar, aPoint];
        
        NSRange addRange = [compStr safeRangeOfString:aChar];//连接符range
        NSRange pointRange = [compStr safeRangeOfString:@" 积分"];//积分range
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:compStr];
        [attributedString setAttributes:aAttributes range:NSMakeRange(0, addRange.location)];
        [attributedString setAttributes:cAttributes range:addRange];
        [attributedString setAttributes:bAttributes range:NSMakeRange(addRange.location+addRange.length, pointRange.location-addRange.location-addRange.length)];
        [attributedString setAttributes:cAttributes range:pointRange];
        return attributedString;
    }
}

/**
 *  功能:价格积分(eg:XXX¥99.9 + 10 积分) 或 (eg:XXX¥99.9\n10 积分)
 */
+ (NSAttributedString *)attStringWithHeadStr:(NSString *)aHeadStr
                                       price:(CGFloat)aPrice
                                       point:(NSInteger)aPoint
                                    joinChar:(NSString *)aChar
                              headAttributes:(NSDictionary *)aHeadStrAtt
                             priceAttributes:(NSDictionary *)aPriceAtt
                             pointAttributes:(NSDictionary *)aPointAtt
                              charAttributes:(NSDictionary *)aCharAtt
{
    NSString *headStr = aHeadStr;
    if (headStr == nil) {
        headStr = @"";
    }
    
    if (aPoint <= 0) {
        NSString *compStr = [NSString stringWithFormat:@"%@%@", aHeadStr, [NSNumber moneyFormat:aPrice]];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:compStr];
        [attributedString setAttributes:aHeadStrAtt range:NSMakeRange(0, aHeadStr.length)];
        [attributedString setAttributes:aPriceAtt range:NSMakeRange(aHeadStr.length, compStr.length-aHeadStr.length)];
        return attributedString;
    } else if (aPrice <= 0.0) {
        NSString *compStr = [NSString stringWithFormat:@"%@%zd 积分", aHeadStr, aPoint];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:compStr];
        [attributedString setAttributes:aHeadStrAtt range:NSMakeRange(0, aHeadStr.length)];
        [attributedString setAttributes:aPointAtt range:NSMakeRange(aHeadStr.length, compStr.length-3-aHeadStr.length)];
        [attributedString setAttributes:aCharAtt range:NSMakeRange(compStr.length-3, 3)];
        return attributedString;
    } else {
        NSString *compStr = [NSString stringWithFormat:@"%@%@%@%zd 积分", aHeadStr, [NSNumber moneyFormat:aPrice], aChar, aPoint];
        
        NSRange addRange = [compStr safeRangeOfString:aChar];//连接符range
        NSRange pointRange = [compStr safeRangeOfString:@" 积分"];//积分range
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:compStr];
        [attributedString setAttributes:aHeadStrAtt range:NSMakeRange(0, aHeadStr.length)];
        [attributedString setAttributes:aPriceAtt range:NSMakeRange(aHeadStr.length, addRange.location-aHeadStr.length)];
        [attributedString setAttributes:aCharAtt range:addRange];
        [attributedString setAttributes:aPointAtt range:NSMakeRange(addRange.location+addRange.length, pointRange.location-addRange.location-addRange.length)];
        [attributedString setAttributes:aCharAtt range:pointRange];
        return attributedString;
    }
}


+ (NSAttributedString *)attStringNoTagWithHeadStr:(NSString *)aHeadStr
                                       price:(CGFloat)aPrice
                                       point:(NSInteger)aPoint
                                    joinChar:(NSString *)aChar
                              headAttributes:(NSDictionary *)aHeadStrAtt
                             priceAttributes:(NSDictionary *)aPriceAtt
                             pointAttributes:(NSDictionary *)aPointAtt
                              charAttributes:(NSDictionary *)aCharAtt
{
    NSString *headStr = aHeadStr;
    if (headStr == nil) {
        headStr = @"";
    }
    
    if (aPoint <= 0) {
        NSString *compStr = [NSString stringWithFormat:@"%@%@", aHeadStr, [NSNumber valueFormat:aPrice]];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:compStr];
        [attributedString setAttributes:aHeadStrAtt range:NSMakeRange(0, aHeadStr.length)];
        [attributedString setAttributes:aPriceAtt range:NSMakeRange(aHeadStr.length, compStr.length-aHeadStr.length)];
        return attributedString;
    } else if (aPrice <= 0.0) {
        NSString *compStr = [NSString stringWithFormat:@"%@%zd 积分", aHeadStr, aPoint];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:compStr];
        [attributedString setAttributes:aHeadStrAtt range:NSMakeRange(0, aHeadStr.length)];
        [attributedString setAttributes:aPointAtt range:NSMakeRange(aHeadStr.length, compStr.length-3-aHeadStr.length)];
        [attributedString setAttributes:aCharAtt range:NSMakeRange(compStr.length-3, 3)];
        return attributedString;
    } else {
        NSString *compStr = [NSString stringWithFormat:@"%@%@%@%zd 积分", aHeadStr, [NSNumber valueFormat:aPrice], aChar, aPoint];
        
        NSRange addRange = [compStr safeRangeOfString:aChar];//连接符range
        NSRange pointRange = [compStr safeRangeOfString:@" 积分"];//积分range
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:compStr];
        [attributedString setAttributes:aHeadStrAtt range:NSMakeRange(0, aHeadStr.length)];
        [attributedString setAttributes:aPriceAtt range:NSMakeRange(aHeadStr.length, addRange.location-aHeadStr.length)];
        [attributedString setAttributes:aCharAtt range:addRange];
        [attributedString setAttributes:aPointAtt range:NSMakeRange(addRange.location+addRange.length, pointRange.location-addRange.location-addRange.length)];
        [attributedString setAttributes:aCharAtt range:pointRange];
        return attributedString;
    }
}



@end
