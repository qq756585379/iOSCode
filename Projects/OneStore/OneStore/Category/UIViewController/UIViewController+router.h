//
//  UIViewController+router.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OTSMappingVO;

@interface UIViewController (router)
/**
 *  OTS创建的时候的参数,如果不为nil，则标识是从router创建的,其中会传递OTSRouterCallbackKey的block用来回调
 */
@property (nonatomic, strong) NSDictionary *extraData;//for init
/**
 *  通过mappingvo的key创建vc
 */
+ (instancetype)createWithMappingVOKey:(NSString *)aKey extraData:(NSDictionary *)aParam;
/**
 *  vc创建
 *
 *  @param aMappingVO OTSMappingVO
 *  @param aParam     创建参数
 *
 *  @return OTSVC
 */
+ (instancetype)createWithMappingVO:(OTSMappingVO *)aMappingVO extraData:(NSDictionary *)aParam;

@end
