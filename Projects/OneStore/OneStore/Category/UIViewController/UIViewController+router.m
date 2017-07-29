//
//  UIViewController+router.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "UIViewController+router.h"
#import "NSObject+category.h"
#import "OTSRouter.h"
#import "CommonDefine.h"

@implementation UIViewController (router)

- (void)setExtraData:(NSDictionary *)extraData{
    [self objc_setAssociatedObject:@"extraData" value:extraData policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}

- (NSDictionary *)extraData{
    return [self objc_getAssociatedObject:@"extraData"];
}

#pragma mark - 通过OTSMappingVO创建VC
+ (instancetype)createWithMappingVOKey:(NSString *)aKey extraData:(NSDictionary *)aParam{
    return [self createWithMappingVO:[OTSRouter singletonInstance].mapping[aKey] extraData:aParam];
}

+ (instancetype)createWithMappingVO:(OTSMappingVO *)aMappingVO extraData:(NSDictionary *)aParam{
    if (aMappingVO.className == nil) {
        DLog(@"OTSMappingVO error %@, className is nil",aMappingVO.description);
        return nil;
    }
    Class class = NSClassFromString(aMappingVO.className);
    if (!class) {
        DLog(@"OTSMappingVO error %@, no such class",aMappingVO);
        return nil;
    }
    UIViewController *vc = nil;
    if (aMappingVO.createdType == OTSMappingClassCreateByCode) {
        vc = [[class alloc] initWithNibName:nil bundle:nil];
    }else if (aMappingVO.createdType == OTSMappingClassCreateByXib) {
        vc = [[class alloc] initWithNibName:aMappingVO.nibName bundle:nil];
    }else if (aMappingVO.createdType == OTSMappingClassCreateByStoryboard) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:aMappingVO.storyboardName bundle:nil];
        vc = [storyboard instantiateViewControllerWithIdentifier:aMappingVO.storyboardID];
    }
    aParam = aParam ?: @{};
    vc.extraData = aParam;
    return vc;
}

+ (NSBundle *)getBundleWithBundleName:(NSString *)aBundleName{
    NSBundle *bundle = [NSBundle mainBundle];
    if (aBundleName.length) {
        bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:aBundleName withExtension:@"bundle"]];
    }
    return bundle;
}

@end
