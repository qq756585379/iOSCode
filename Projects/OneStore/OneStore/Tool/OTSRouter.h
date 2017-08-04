//
//  OTSRouter.h
//  OneStore
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "OTSMappingVO.h"
#import "OTSNativeFuncVO.h"
#import "NSDictionary+router.h"

@interface OTSRouter : NSObject

+ (instancetype)singletonInstance;

@property (nonatomic, strong) NSMutableDictionary *mapping;
@property (nonatomic, strong, readonly) UIViewController *rootVC;
@property (nonatomic, strong, readonly) NSString *appScheme;
@property (nonatomic, strong, readonly) NSString *appFuncScheme;
@property (nonatomic, strong, readonly) NSArray *tabArray;
@property (nonatomic, strong, readonly) UIViewController *pcContainer;
@property (nonatomic, assign, readonly) OTSPlatformType platformType;

/**
 *  功能:最顶层显示的vc
 */
- (UIViewController *)topVC;

- (BOOL)isPhone;
- (BOOL)isPad;

- (void)registerRootVC:(UIViewController *)aRootVC;
- (void)registerTabArray:(NSArray *)aTabArray;
- (void)registerPCContainer:(UIViewController *)aRootVC;

#pragma mark - Register
/**
 *  功能:注册VC
 *
 *  @param aVO      OTSMappingVO
 *  @param aKeyName 对应的Key
 */
- (void)registerRouterVO:(OTSMappingVO *)aVO withKey:(NSString *)aKeyName;

/**
 *  功能:注册本地方法
 *
 *  @param aVO      OTSNativeFuncVO
 *  @param aKeyName 对应的Key
 */
- (void)registerNativeFuncVO:(OTSNativeFuncVO *)aVO withKey:(NSString *)aKeyName;

#pragma mark - Router
/**
 *  功能:按照url执行
 *
 *  @param aUrl 需要解析的url
 *
 *  @return 跳转的界面(NSArray<OTSVC *>)或者func返回的数据(id),如果跳转到登陆则返回NSNull
 */
- (id)routerWithUrl:(NSURL *)aUrl;

/**
 *  功能:按照url执行,完成之后执行block回调
 *
 *  @param aUrl   需要解析的url
 *  @param aBlock 回调block
 *
 *  @return 跳转的界面(NSArray<OTSVC *>)或者func返回的数据(id),如果跳转到登陆则返回NSNull
 */
- (id)routerWithUrl:(NSURL *)aUrl callbackBlock:(OTSNativeFuncVOBlock)aBlock;

/**
 *  功能:按照url执行
 *
 *  @param aUrlString 需要解析的NSString url,所以请传入urlencode的字符串
 *
 *  @return 跳转的界面(NSArray<OTSVC *>)或者func返回的数据(id),如果跳转到登陆则返回NSNull
 */
- (id)routerWithUrlString:(NSString *)aUrlString;

/**
 *  功能:按照url执行,完成之后执行block回调
 *
 *  @param aUrlString   需要解析的NSString url,所以请传入urlencode的字符串
 *  @param aBlock 回调block
 *
 *  @return 跳转的界面(NSArray<UIViewController *>)或者func返回的数据(id),如果跳转到登陆则返回NSNull
 */
- (id)routerWithUrlString:(NSString *)aUrlString callbackBlock:(OTSNativeFuncVOBlock)aBlock;

/**
 *  功能:回到root
 */
- (NSArray *)routerToRoot;

/**
 *  功能:去登录
 */
- (void)routerToLogin;

/**
 *  功能:进入首页
 */
- (id)enterHomepage;

@end
