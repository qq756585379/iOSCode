//
//  OTSWeakObjectDeathNotifier.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "OTSWeakObjectDeathNotifier.h"
#import "NSObject+category.h"
#import <objc/runtime.h>

@interface OTSWeakObjectDeathNotifier ()
@property (nonatomic, copy) OTSWeakObjectDeathNotifierBlock aBlock;
@end

@implementation OTSWeakObjectDeathNotifier

- (void)setBlock:(OTSWeakObjectDeathNotifierBlock)block{
    self.aBlock = block;
}

- (void)dealloc{
    if (self.aBlock) {
        self.aBlock(self);
    }
    self.aBlock = nil;
}

- (void)setOwner:(id)owner{
    _owner = owner;
    NSString *str = [NSString stringWithFormat:@"observerOwner_%p",self];
    [owner objc_setAssociatedObject:str value:self policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}

@end
