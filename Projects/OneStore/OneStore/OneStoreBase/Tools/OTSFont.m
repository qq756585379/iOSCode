//
//  OTSFont.m
//  OneStoreFramework
//
//  Created by Aimy on 10/5/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "OTSFont.h"

#import "OTSFuncDefine.h"

@implementation OTSFont

+ (UIFont *)otsNumberFontOfSize:(CGFloat)fontSize
{
    return [self fontWithName:@"Futura" size:fontSize];
}

+ (UIFont *)small
{
    CGFloat fontSize = 10;
    if (IS_IPAD_DEVICE) {
        fontSize = 12;
    }
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)medium
{
    CGFloat fontSize = 12;
    if (IS_IPAD_DEVICE) {
        fontSize = 14;
    }
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)large
{
    CGFloat fontSize = 14;
    if (IS_IPAD_DEVICE) {
        fontSize = 16;
    }
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)bigLarge
{
    CGFloat fontSize = 18;
    if (IS_IPAD_DEVICE) {
        fontSize = 20;
    }
    return [UIFont systemFontOfSize:fontSize];
}
@end
