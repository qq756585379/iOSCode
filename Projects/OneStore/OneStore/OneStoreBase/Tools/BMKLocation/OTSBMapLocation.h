//
//  OTSBMapLocation.h
//  OneStoreBase
//
//  Created by Eason Qian on 15/10/30.
//  Copyright © 2015年 OneStoreBase. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLPlacemark;
@class CLLocation;

//加个addressDictionary方便模拟数据
typedef void (^OTSBMKLocationCompleteBlock)(NSDictionary *addressDictionary, CLLocation *aLocation);

@interface OTSBMapLocation : NSObject

- (void)start;
- (void)startWithCompleteBlock:(OTSBMKLocationCompleteBlock)block;
- (void)stop;

@end
