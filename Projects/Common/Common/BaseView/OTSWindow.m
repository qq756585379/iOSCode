//
//  OTSWindow.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "OTSWindow.h"
#import "OTSNotificationDefine.h"
#import "NSObject+BeeNotification.h"

@implementation OTSWindow

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    [super motionEnded:motion withEvent:event];
    if (motion == UIEventSubtypeMotionShake) {
        [self postNotification:OTS_NOTIFICATION_SHAKE];
    }
}

@end
