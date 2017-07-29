//
//  OTSWeakObjectDeathNotifier.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>
//当owner释放的时候通知block
@class OTSWeakObjectDeathNotifier;

typedef void(^OTSWeakObjectDeathNotifierBlock)(OTSWeakObjectDeathNotifier *sender);

@interface OTSWeakObjectDeathNotifier : NSObject

@property (nonatomic,   weak) id owner;
@property (nonatomic, strong) id data;

- (void)setBlock:(OTSWeakObjectDeathNotifierBlock)block;

@end
