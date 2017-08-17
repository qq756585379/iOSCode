//
//  UIColor.m
//  MingpinProject
//
//  Created by Xiao Wei on 14-9-29.
//
//

#import "UIColor+CustomColor.h"

@implementation UIColor(CustomColor)

+(UIColor*)r:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue a:(CGFloat)alpha{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+(UIColor*)contentCell_QBuy{
    return [UIColor r:233 g:233 b:233 a:1];
}

+(UIColor*)contentTitle_QBuy{
    return [UIColor r:102 g:102 b:102 a:1];
}

+(UIColor*)contentPrice_QBuy{
    return [UIColor r:235 g:97 b:0 a:1];
}

+(UIColor*)contentOldPriceColor_QBuy{
    return [UIColor r:153 g:153 b:153 a:1];
}

+(UIColor*)propertyBox_QBuy{
    return [UIColor r:238 g:186 b:104 a:1];
}

+(UIColor*)subDetailTab_QBuy{
    return [UIColor r:230 g:230 b:230 a:1];
}

@end
