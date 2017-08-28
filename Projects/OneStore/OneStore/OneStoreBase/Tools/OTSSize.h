//
//  OTSSize.h
//  OneStoreFramework
//
//  Created by Aimy on 14/11/30.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum OTSSizeType
{
    OTSSizeTypeNone = 0,
    OTSSizeType3_5,
    OTSSizeType4_0,
    OTSSizeType4_7,
    OTSSizeType5_5,
    OTSSizeType9_7,
    OTSSizeType9_7_LAND,
} OTSSizeType;

#define OTSScaledLength(lengthValue) [OTSSize getLengthWithSizeType:OTSSizeType4_7 andLength:(lengthValue)]

@interface OTSSize : NSObject

+ (CGFloat)getLengthWithSizeType:(OTSSizeType)sizeType andLength:(CGFloat)length;

+ (CGFloat)getRatioLengthWithSizeType:(OTSSizeType)sizeType andLength:(CGFloat)length;

@end

#define OTS_RATIO_LENGTH(length) IS_IPHONE_DEVICE ? OTS_PHONE_RATIO_LENGTH(length) : OTS_PAD_RATIO_LENGTH(length)
#define OTS_PHONE_RATIO_LENGTH(length) [OTSSize getLengthWithSizeType:OTSSizeType4_7 andLength:length]
#define OTS_PAD_RATIO_LENGTH(length) [OTSSize getLengthWithSizeType:OTSSizeType9_7 andLength:length]
