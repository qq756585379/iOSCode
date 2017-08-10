//
//  PhoneCartNC.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/21.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "PhoneCartNC.h"
#import "NSObject+PerformBlock.h"

@interface PhoneCartNC ()

@end

@implementation PhoneCartNC

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        [[OTSGlobalValue sharedInstance] addObserver:self forKeyPath:@"cartCount" options:NSKeyValueObservingOptionInitial context:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)updateNum:(NSNumber *)aCount{
    NSInteger count = aCount.integerValue;
    if (count <= 0) {
        self.tabbarItem.badgeValue = nil;
    }else {
        if (count > 99) {
            self.tabbarItem.badgeValue = @"99+";
        }else {
            self.tabbarItem.badgeValue = [NSString stringWithFormat:@"%@ ",@(count)];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self performInMainThreadBlock:^{
        OTSGlobalValue *value = object;
        [self updateNum:value.cartCount];
    }];
}

- (void)dealloc{
    [[OTSGlobalValue sharedInstance] removeObserver:self forKeyPath:@"cartCount"];
}

@end






