//
//  AlertViewManager.h
//  TZTV
//
//  Created by Luosa on 2016/12/22.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^OTSAlertViewBlock)(NSInteger buttonIndex);

@interface AlertViewManager : NSObject

+ (void)alertWithMessage:(NSString *)aMessage
        andCompleteBlock:(OTSAlertViewBlock)aBlock;

+ (void)alertWithTitle:(NSString *)aTitle
               message:(NSString *)aMessage
      andCompleteBlock:(OTSAlertViewBlock)aBlock;

+ (void)alertWithTitle:(NSString *)aTitle
               message:(NSString *)aMessage
               leftBtn:(NSString *)leftBtnName
              rightBtn:(NSString *)rightBtnName
      andCompleteBlock:(OTSAlertViewBlock)aBlock;

@property (nonatomic, copy) OTSAlertViewBlock block;

@end
