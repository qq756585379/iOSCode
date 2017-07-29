//
//  NSObject+BeeNotification.m
//  Common
//
//  Created by 杨俊 on 2017/7/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "NSObject+BeeNotification.h"
#import "NSObject+PerformBlock.h"

@implementation NSObject (BeeNotification)

- (void)handleNotification:(NSNotification *)notification{
    
}

- (void)observeNotification:(NSString *)name{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:name
                                               object:nil];
}

- (void)unobserveNotification:(NSString *)name{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:name
                                                  object:nil];
}

- (void)unobserveAllNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)postNotification:(NSString *)name{
    [self postNotification:name withObject:nil userInfo:nil];
}

- (void)postNotification:(NSString *)name withObject:(NSObject *)object{
    [self postNotification:name withObject:object userInfo:nil];
}

- (void)postNotification:(NSString *)name withObject:(NSObject *)object userInfo:(NSDictionary *)info{
    [self performInMainThreadBlock:^{
        @try {
            [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:info];
        }@catch (NSException *exception) {
            
        }@finally {
            
        }
    }];
}

@end
