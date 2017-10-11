//
//  UIViewController+dealloc.m
//  TZTV
//
//  Created by Luosa on 2016/12/15.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "CommonDefine.h"
#import "LogDefine.h"

@implementation UIViewController (dealloc)

//不需要包含头文件，因为load是装进内存就会调用
+ (void)load{
    Method method1 = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod(self, @selector(yj_dealloc));
    //交换了dealloc和yj_dealloc方法
    method_exchangeImplementations(method1, method2);
}

#pragma mark - 每次控制器释放的时候调用dealloc替换为yj_dealloc方法
//通过该方法可以看到页面有没有被释放
- (void)yj_dealloc{
    DLog(@"common:  %@ ----------  dealloc", self);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //此时调用yj_dealloc又会调用dealloc方法，因为两者方法交换了,这句话不能少，不然会有bug
    [self yj_dealloc];//这里调用的是dealloc方法
}

@end
