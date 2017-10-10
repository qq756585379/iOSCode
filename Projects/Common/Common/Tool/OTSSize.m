//
//  OTSSize.m
//  OneStoreFramework
//
//  Created by Aimy on 14/11/30.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "OTSSize.h"

@implementation OTSSize

+ (CGFloat)getLengthWithSizeType:(OTSSizeType)sizeType andLength:(CGFloat)length
{
    CGFloat resultLength = length * [[self multiplicative][@([self getCurrentSizeType])] doubleValue] / [[self multiplicative][@(sizeType)] doubleValue];
    resultLength = ceil(resultLength);
    
    return resultLength;
}

+ (CGFloat)getRatioLengthWithSizeType:(OTSSizeType)sizeType andLength:(CGFloat)length
{
    CGFloat resultLength = length * [[self multiplicative][@([self getCurrentRatioSizeType])] doubleValue] / [[self multiplicative][@(sizeType)] doubleValue];
    resultLength = ceil(resultLength);
    
    return resultLength;
}

+ (OTSSizeType)getCurrentRatioSizeType
{
    static OTSSizeType currentRatioSizeType = OTSSizeTypeNone;
    
    if (ISIPHONE3_5) {
        currentRatioSizeType = OTSSizeType3_5;
    }
    else if (ISIPHONE4_0) {
        currentRatioSizeType = OTSSizeType4_0;
    }
    else if (ISIPHONE4_7) {
        currentRatioSizeType = OTSSizeType4_7;
    }
    else if (ISIPHONE5_5) {
        currentRatioSizeType = OTSSizeType5_5;
    }
    else if (ISIPHONE9_7) {
        currentRatioSizeType = OTSSizeType9_7;
    }
    else if(ISIPHONE9_7_LAND){
        currentRatioSizeType = OTSSizeType9_7_LAND;
    }
    
    return currentRatioSizeType;
}

+ (OTSSizeType)getCurrentSizeType
{
    static OTSSizeType currentSizeType = OTSSizeTypeNone;
    
    if (currentSizeType == OTSSizeTypeNone) {
        if (ISIPHONE3_5) {
            currentSizeType = OTSSizeType3_5;
        }
        else if (ISIPHONE4_0) {
            currentSizeType = OTSSizeType4_0;
        }
        else if (ISIPHONE4_7) {
            currentSizeType = OTSSizeType4_7;
        }
        else if (ISIPHONE5_5) {
            currentSizeType = OTSSizeType5_5;
        }
        else if (ISIPHONE9_7) {
            currentSizeType = OTSSizeType9_7;
        }
        else if(ISIPHONE9_7_LAND){
            currentSizeType = OTSSizeType9_7;
        }
    }
    
    return currentSizeType;
}

+ (NSDictionary *)multiplicative
{
    return @{@0:@0,
             @1:@320,
             @2:@320,
             @3:@375,
             @4:@414,
             @5:@768,
             @6:@1024};
}

@end
