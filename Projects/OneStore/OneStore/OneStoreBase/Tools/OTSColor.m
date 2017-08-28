//
//  OTSColor.m
//  OneStoreFramework
//
//  Created by Aimy on 8/25/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "OTSColor.h"

@implementation OTSColor

+ (UIColor *)colorWithRGB:(NSUInteger)aRGB
{
    return [UIColor colorWithRed:((float)((aRGB & 0xFF0000) >> 16))/255.0 green:((float)((aRGB & 0xFF00) >> 8))/255.0 blue:((float)(aRGB & 0xFF))/255.0 alpha:1.0];
}

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length
{
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    
    return hexComponent / 255.0;
}
+ (UIColor *)hex:(NSString *)hexString
{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch([colorString length])
    {
        case 3: // #RGB
            alpha = 1.0f;
            red = [self colorComponentFrom:colorString start:0 length:1];
            green = [self colorComponentFrom:colorString start:1 length:1];
            blue = [self colorComponentFrom:colorString start:2 length:1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom:colorString start:0 length:1];
            red = [self colorComponentFrom:colorString start:1 length:1];
            green = [self colorComponentFrom:colorString start:2 length:1];
            blue = [self colorComponentFrom:colorString start:3 length:1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red = [self colorComponentFrom:colorString start:0 length:2];
            green = [self colorComponentFrom:colorString start:2 length:2];
            blue = [self colorComponentFrom:colorString start:4 length:2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom:colorString start:0 length:2];
            red = [self colorComponentFrom:colorString start:2 length:2];
            green = [self colorComponentFrom:colorString start:4 length:2];
            blue = [self colorComponentFrom:colorString start:6 length:2];
            break;
        default:
            return nil;
            break;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)bgColor
{
    return [ self colorWithRGB:0xeeeeee];
}

+ (UIColor *)gray
{
	return [self colorWithRGB:0x757575];
}

+ (UIColor *)lightGray
{
	return [self colorWithRGB:0xbdbdbd];
}


+(UIColor *)darkGray
{
	return [self colorWithRGB:0x212121];
}

+ (UIColor *)red
{
	return [self colorWithRGB:0xff3c25];
}

+ (UIColor *)orange
{
    return [self colorWithRGB:0xff9800];
}

+ (UIColor *)green
{
	return [self colorWithRGB:0x97d054];
}

+ (UIColor *)darkRed
{
	return [self colorWithRGB:0xd32d21];
}

+(UIColor*)lightGreen{

    return [self colorWithRGB:0x6cae38];
}

+(UIColor*)Blue{

    return [self colorWithRGB:0x007ac5];
}

+(UIColor*)allWhite{

    return [self colorWithRGB:0xFFFFFF];
}

+(UIColor*)allBlack{

    return [self colorWithRGB:0x000000];
}

+(UIColor*)heightBlack{
  
    return [self colorWithRGB:0x333333];
}

+(UIColor*)heightGray{
 
    return [self colorWithRGB:0x666666];
}

+(UIColor*)theLightGray{
 
    return [self colorWithRGB:0x999999];
}

+(UIColor*)lightBlue{

    return [self colorWithRGB:0x007AC5];
}

+(UIColor*)lightBlack{

    return [self colorWithRGB:0xd5d5d5];
}

+(UIColor*)theGrayColor{

    return [self colorWithRGB:0xf1f1f1];
}

+(UIColor*)theRedColor{

    return [self colorWithRGB:0xF95E65];
}

+(UIColor*)theYellowColor{
    
    return [self colorWithRGB:0xffc107];
}

+(UIColor*)thePurpleColor{
    
    return [self colorWithRGB:0xce98d3];
}

+(UIColor*)theBlueColor{
    
    return [self colorWithRGB:0x00AEFC];
}

+(UIColor*)theOrangeColor{
    
    return [self colorWithRGB:0xFF8A65];
}

+(UIColor*)lightGrayColor{

    return [self colorWithRGB:0xf9f9f9];
}

+(UIColor*)naveColor{

    return [self colorWithRGB:0x7f93f1];
}

+(UIColor*)paleRedColor{

    return [self colorWithRGB:0xfd686c];
}

+(UIColor*)theLightBlack{

    return [self colorWithRGB:0xe0e0e0];
}

+(UIColor*)waterGreenColor{

    return [self colorWithRGB:0x35ca85];
}


/**
 *	我店红，擦擦
 *
 *	@return UIColor
 */
+(UIColor*)bgRed {
    return [UIColor colorWithRed:220.0/255 green:0/255 blue:0/255 alpha:1];
}

/**
 *	我店字体灰，呵呵呵
 *
 *	@return UIColor
 */
+(UIColor*)textGray {
    return [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1];
}

+ (UIColor *)randomColor
{
    CGFloat hue = (arc4random() % 256 / 256.0);
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}


@end
