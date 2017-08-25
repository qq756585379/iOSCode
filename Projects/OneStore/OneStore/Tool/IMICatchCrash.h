//
//  IMICatchCrash.h
//  TuyaSmartCamera
//
//  Created by 杨俊 on 2017/7/21.
//  Copyright © 2017年 tuya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMICatchCrash : NSObject

void uncaughtExceptionHandler(NSException *exception);

@end
