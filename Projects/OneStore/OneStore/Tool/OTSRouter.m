//
//  OTSRouter.m
//  OneStore
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import "OTSRouter.h"
#import "NSString+router.h"
#import "OTSBIGlobalValue.h"
#import "OTSJsonKit.h"
#import "OTSGlobalValue.h"
#import "UIViewController+base.h"
#import "NSObject+PerformBlock.h"
#import "OTSPresentController.h"
#import "UIViewController+router.h"
#import "OTSConst.h"
#import "OTSUserDefaultDefine.h"
#import "OTSUserDefault.h"

@interface OTSRouter()
@property (nonatomic, strong) NSMutableDictionary *nativeFuncMapping;
@property (nonatomic, strong) UIViewController *rootVC;
@property (nonatomic, strong) UIViewController *pcContainer;
@property (nonatomic, strong) NSString *appScheme;
@property (nonatomic, strong) NSString *appFuncScheme;
@property (nonatomic, strong) NSArray *tabArray;
@property (nonatomic, assign) OTSPlatformType platformType;
@end

@implementation OTSRouter

+ (instancetype)singletonInstance{
    static OTSRouter *router = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        router = [OTSRouter new];
    });
    return router;
}

- (instancetype)init{
    if (self = [super init]) {
        self.mapping = [NSMutableDictionary dictionary];
        self.nativeFuncMapping = [NSMutableDictionary dictionary];
        if (IS_IPHONE_DEVICE) {
            self.platformType = OTSPlatformTypePhone;
        } else {
            self.platformType = OTSPlatformTypePad;
        }
        NSString *bundleIdentifier = [NSBundle mainBundle].bundleIdentifier;
        if ([bundleIdentifier rangeOfString:@"sam"].location != NSNotFound) {
            self.appScheme = @"sam";
            self.appFuncScheme = @"samiosfun";
        } else {
            self.appScheme = @"yhd";
            self.appFuncScheme = @"yhdiosfun";
        }
    }
    return self;
}

- (UIViewController *)topVC{
    if ([self.rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tbc = (id)self.rootVC;
        UIViewController *selectedVC = tbc.selectedViewController;
        if ([selectedVC isKindOfClass:[UINavigationController class]]) {
            return [(UINavigationController *)selectedVC topViewController];
        } else {
            NSLog(@"没有导航怎么pop?");
        }
    } else if ([self.rootVC isKindOfClass:[UINavigationController class]]) {
        return [(UINavigationController *)self.rootVC topViewController];
    }
    return nil;
}

- (BOOL)isPhone{
    return self.platformType == OTSPlatformTypePhone;
}

- (BOOL)isPad{
    return self.platformType == OTSPlatformTypePad;
}

- (void)registerRootVC:(UIViewController *)aRootVC{
    if (self.rootVC) {
        DLog(@"已经设置了rootvc，不能重复设置");
        return ;
    }
    self.rootVC = aRootVC;
}

- (void)registerTabArray:(NSArray *)aTabArray{
    if (self.tabArray) {
        DLog(@"已经设置了tabarray，不能重复设置");
        return ;
    }
    self.tabArray = aTabArray;
}

- (void)registerPCContainer:(UIViewController *)aPCContainer{
    if (self.pcContainer) {
        DLog(@"已经设置了pc Container，不能重复设置");
        return ;
    }
    self.pcContainer = aPCContainer;
}

#pragma mark - Register
/**
 *  功能:注册VC
 *
 *  @param aVO      OTSMappingVO
 *  @param aKeyName 对应的Key
 */
- (void)registerRouterVO:(OTSMappingVO *)aVO withKey:(NSString *)aKeyName{
    if (IS_IPHONE_DEVICE && aVO.loadFilterType==OTSMappingClassPlatformTypePad) {
        return;
    } else if (IS_IPAD_DEVICE && aVO.loadFilterType==OTSMappingClassPlatformTypePhone) {
        return;
    }
    aKeyName = [aKeyName lowercaseString];
    if (self.mapping[aKeyName]) {
        DLog(@"overwrite router vo key[%@], mapping vo,%@", aKeyName, self.mapping[aKeyName]);
    }
    self.mapping[aKeyName] = aVO;
}

/**
 *  功能:注册本地方法
 *
 *  @param aVO      OTSNativeFuncVO
 *  @param aKeyName 对应的Key
 */
- (void)registerNativeFuncVO:(OTSNativeFuncVO *)aVO withKey:(NSString *)aKeyName{
    if (IS_IPHONE_DEVICE && aVO.funcFilterType==OTSMappingClassPlatformTypePad) {
        return;
    } else if (IS_IPAD_DEVICE && aVO.funcFilterType==OTSMappingClassPlatformTypePhone) {
        return;
    }
    aKeyName = [aKeyName lowercaseString];
    if (self.nativeFuncMapping[aKeyName]) {
        DLog(@"overwrite native func vo key[%@], mapping vo,%@", aKeyName, self.nativeFuncMapping[aKeyName]);
    }
    self.nativeFuncMapping[aKeyName] = aVO;
}

#pragma mark - Router
/**
 *  功能:按照url执行
 *
 *  @param aUrl 需要解析的url
 *
 *  @return 跳转的界面(NSArray<OTSVC *>)或者func返回的数据(id),如果跳转到登陆则返回NSNull
 */
- (id)routerWithUrl:(NSURL *)aUrl{
    return [self routerWithUrl:aUrl callbackBlock:nil];
}

/**
 *  功能:按照url执行,完成之后执行block回调
 *
 *  @param aUrl   需要解析的url
 *  @param aBlock 回调block
 *
 *  @return 跳转的界面(NSArray<OTSVC *>)或者func返回的数据(id),如果跳转到登陆则返回NSNull
 */
- (id)routerWithUrl:(NSURL *)aUrl callbackBlock:(OTSNativeFuncVOBlock)aBlock{
    if (!aUrl) {
        DLog(@"router error url");
        return nil;
    }
    NSString *scheme = aUrl.scheme;
    NSString *host = [aUrl.host lowercaseString];
    NSString *query = aUrl.query;
    NSMutableDictionary *params = ((NSDictionary *)([NSString getDictFromJsonString:query][OTSRouterParamKey])).mutableCopy;
    params[OTSRouterFromHostKey]  	= host;
    params[OTSRouterFromSchemeKey] 	= scheme;
    params[OTSRouterCallbackKey] 	= aBlock;
    
    //监听有打开渠道的router
    [[OTSBIGlobalValue sharedInstance] generateSessionId];
    NSString *btu = params[@"tracker_u"];
    if (btu) {
        [OTSUserDefault setValue:btu forKey:BI_OpenTrucku];
    }
    //根据scheme处理
    if ([scheme isEqualToString:self.appScheme]) {
        return [self p_routeVCWithHost:host params:params];
    } else if ([scheme isEqualToString:self.appFuncScheme]) {
        return [self p_routeNativeFuncWithHost:host params:params];
    } else if ([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"]) {
        return [self p_routeWebWithUrl:aUrl];
    } else {
        NSLog(@"is not a router url,%@", aUrl.absoluteString.stringByRemovingPercentEncoding);
        return nil;
    }
}

/**
 *  功能:按照url执行
 *
 *  @param aUrlString 需要解析的NSString url,所以请传入urlencode的字符串
 *
 *  @return 跳转的界面(NSArray<OTSVC *>)或者func返回的数据(id),如果跳转到登陆则返回NSNull
 */
- (id)routerWithUrlString:(NSString *)aUrlString{
    return [self routerWithUrlString:aUrlString callbackBlock:nil];
}

/**
 *  功能:按照url执行,完成之后执行block回调
 *
 *  @param aUrlString   需要解析的NSString url,所以请传入urlencode的字符串
 *  @param aBlock 回调block
 *
 *  @return 跳转的界面(NSArray<UIViewController *>)或者func返回的数据(id),如果跳转到登陆则返回NSNull
 */
- (id)routerWithUrlString:(NSString *)aUrlString callbackBlock:(OTSNativeFuncVOBlock)aBlock{
    NSLog(@"aUrlString = %@",aUrlString.stringByRemovingPercentEncoding);
    NSURL *url = [NSURL URLWithString:aUrlString];
    if (!url) {
        url = [NSURL URLWithString:[aUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    return [self routerWithUrl:url callbackBlock:aBlock];
}

- (NSArray *)routerBack{
    if ([self.rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tbc = (id)self.rootVC;
        UIViewController *selectedVC = tbc.selectedViewController;
        if ([selectedVC isKindOfClass:[UINavigationController class]]) {
            UIViewController *vc = [(UINavigationController *)selectedVC popViewControllerAnimated:YES];
            if (vc) {
                return @[vc];
            }
            return nil;
        } else {
            DLog(@"没有导航怎么pop?");
        }
    } else if ([self.rootVC isKindOfClass:[UINavigationController class]]) {
        UIViewController *vc = [(UINavigationController *)self.rootVC popViewControllerAnimated:YES];
        if (vc) {
            return @[vc];
        }
        return nil;
    } else {
        DLog(@"没有导航怎么pop?");
    }
    return nil;
}

/**
 *  功能:回到root
 */
- (NSArray *)routerToRoot{
    NSArray *vcs = nil;
    if ([self.rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tbc = (id)self.rootVC;
        vcs = [self p_switchTabAndPopToRoot:tbc.selectedIndex withParams:nil];
    } else if ([self.rootVC isKindOfClass:[UINavigationController class]]) {
        //隐藏PC
        [self p_dismissAllPC];
        UINavigationController *nc = (id)self.rootVC;
        vcs = [nc popToRootViewControllerAnimated:YES];
    }
    return vcs;
}

/**
 *  功能:去登录
 */
- (void)routerToLogin{
    [self routerWithUrl:[NSURL URLWithString:[NSString getRouterVCUrlStringFromUrlString:@"login" andParams:nil]]];
}

/**
 *  功能:进入首页
 */
- (id)enterHomepage{
    if ([self.rootVC isKindOfClass:[UITabBarController class]]) {
        //pop到root
        UITabBarController *tbc = (id)self.rootVC;
        if ([tbc.selectedViewController isKindOfClass:[UINavigationController class]]) {
            if (tbc.selectedIndex != 0) {
                UINavigationController *nc = (id)tbc.selectedViewController;
                if (nc.viewControllers.count > 1) {
                    [self performInMainThreadBlock:^{
                        [nc popToRootViewControllerAnimated:NO];
                        [nc.view setNeedsLayout];
                        [nc.topViewController.tabBarController.view setNeedsLayout];
                    } afterSecond:.5f];
                }
            }
        }
    }
    return  [self p_switchTabAndPopToRoot:0 withParams:nil];
}


/**
 *  功能:route到host对应的vc
 */
- (id)p_routeVCWithHost:(NSString *)aHost params:(NSDictionary *)aParams{
    OTSMappingVO *mappingVO = [self.mapping objectForCaseInsensitiveKey:aHost];
    if (mappingVO == nil) {
        return nil;
    }
    
    //quite apollo
    if ([aHost isEqualToString:@"homepage"] && aParams[@"quitapollo"]) {
        return [self routerWithUrlString:[NSString getRouterFunUrlStringFromUrlString:@"quitapollo" andParams:nil]];
    }
    
    //tab
    NSUInteger index = [self.tabArray indexOfObject:aHost];
    if (index != NSNotFound) {
        if ([aHost isEqualToString:@"cart"] && aParams[@"push"]) {
            return [self p_routeVCWithMappingVO:mappingVO params:aParams];
        } else if(index == 0){
            return [self enterHomepage];
        } else {
            return [self p_switchTabAndPopToRoot:index withParams:aParams];
        }
    }
    return [self p_routeVCWithMappingVO:mappingVO params:aParams];
}

/**
 *  功能:route到web页面
 */
- (id)p_routeWebWithUrl:(NSURL *)aUrl{
    OTSMappingVO *vo = self.mapping[@"web"];
    NSDictionary *params = @{@"url": aUrl.absoluteString};
    return [self p_routeVCWithMappingVO:vo params:params];
}

/**
 *  功能:关闭所有pc
 */
- (void)p_dismissAllPC{
    for (UIViewController *childVC in self.pcContainer.childViewControllers) {
        if ([childVC isPc]) {
            [childVC dismissViewControllerAnimated:NO completion:nil];
            ((OTSPresentController *)childVC).forceDismissed = YES;
        }
    }
}

/**
 *  根据RouterUrl，返回url的参数
 *
 *  @param aUrl :规则:yhd://localweb?body={"path":"leigou"}
 *  * 此方法只能在iOS7以上的系统使用
 */
- (NSDictionary *)getRouterParamWithURL:(NSURL *)aUrl{
    if (!aUrl) {
        return nil;
    }
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:aUrl resolvingAgainstBaseURL:NO];
    NSArray *queryItems = urlComponents.queryItems;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@", OTSRouterParamKey];
    NSURLQueryItem *queryItem = [[queryItems filteredArrayUsingPredicate:predicate] firstObject];
    NSDictionary *resultDict = [OTSJsonKit dictFromString:queryItem.value]?:@{}.mutableCopy;
    return resultDict;
}

#pragma mark - Inner
/**
 *  功能:切到指定的tab，并且pop到root
 */
- (NSArray *)p_switchTabAndPopToRoot:(NSUInteger)aTabIndex withParams:(NSDictionary *)params{
    //隐藏PC
    [self p_dismissAllPC];
    NSArray *vcs = nil;
    if ([self.rootVC isKindOfClass:[UITabBarController class]]) {
        //切到指定的tab
        UITabBarController *tbc = (id)self.rootVC;
        if (tbc.selectedIndex != aTabIndex) {
            UIViewController *vc = [tbc.childViewControllers objectAtIndex:aTabIndex];
            if ([vc isKindOfClass:[UINavigationController class]]) { //如果是 NC 传到 rootContrller
                UINavigationController *nc = (UINavigationController *)vc;
                if (nc.childViewControllers.count > 0) {
                    [nc.childViewControllers firstObject].extraData = params;
                }
            } else {
                vc.extraData = params;
            }
            tbc.selectedIndex = aTabIndex;
        }
        //pop到root
        if ([tbc.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nc = (id)tbc.selectedViewController;
            if (nc.viewControllers.count > 1) {
                vcs = [nc popToRootViewControllerAnimated:YES];
            }
        }
    } else if ([self.rootVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nc = (id)self.rootVC;
        NSArray *tabArray = self.tabArray;
        
        NSString *tabStr = tabArray[aTabIndex];
        OTSMappingVO *tabMappingVO = [self.mapping objectForCaseInsensitiveKey:tabStr];
        Class tabClass = NSClassFromString(tabMappingVO.className);
        NSArray *vcArray = nc.viewControllers.copy;
        NSArray *vcClassArray = [vcArray valueForKeyPath:@"@unionOfObjects.class"];
        
        if (nc.topViewController.class == tabClass) {
            vcs = @[];
        } else if ([vcClassArray containsObject:[tabClass class]]) {
            NSInteger index = [vcClassArray indexOfObject:[tabClass class]];
            UIViewController *tabVC = vcArray[index];
            vcs = [nc popToViewController:tabVC animated:YES];
        } else {
            vcs = [self p_routeVCWithMappingVO:tabMappingVO params:params];
        }
    }
    return vcs;
}

/**
 *  功能:route到OTSMappingVO对应的vc
 */
- (id)p_routeVCWithMappingVO:(OTSMappingVO *)aVO params:(NSDictionary *)aParams{
    //需要登录，则去登录
    if (aVO.needLogin && ![OTSGlobalValue sharedInstance].token) {
        [self routerToLogin];
        return [NSNull null];
    }
    NSNotification *notice = nil;
    if (![aVO.className isEqualToString:@"PhoneCatchCatPC"]) {
        notice = [NSNotification notificationWithName:@"changeVC" object:nil userInfo:nil];
    }
    UIViewController *vc = [UIViewController createWithMappingVO:aVO extraData:aParams];
    if (!vc) {
        DLog(@"router error %@, can not new one",aVO);
        return nil;
    }
    if ([vc isKindOfClass:[UINavigationController class]]) {
        DLog(@"cannot push a nc");
        return nil;
    }
    //Present PC情况处理
    if ([vc isPc]) {
        if ([[self.pcContainer.childViewControllers lastObject] isKindOfClass:[vc class]] && !vc.isPresented) {
            return nil;
        }else{
            if (![vc shouldShareScreen]) {
                [self p_dismissAllPC];
            }
            [vc addToRootVC];
            // hard code：之所以延迟0.1秒，是因为需要上面p_dismissAllPC执行完毕之后再present
            [self performInMainThreadBlock:^{
                [vc presentViewControllerAnimated:YES completion:nil];
            } afterSecond:0.1];
            if (notice) {
                [[NSNotificationCenter defaultCenter] postNotification:notice];
            }
            return @[vc];
        }
    }
    //隐藏PC
    [self p_dismissAllPC];
    //Push VC
    if ([self.rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tbc = (id)self.rootVC;
        UIViewController *selectedVC = tbc.selectedViewController;
        if ([selectedVC isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController *)selectedVC pushViewController:vc animated:YES];
            if (notice) {
                [[NSNotificationCenter defaultCenter] postNotification:notice];
            }
        } else {
            DLog(@"没有导航怎么push?");
        }
    } else if ([self.rootVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nc = (id)self.rootVC;
        UINavigationController *routerNC = nc;
        if (nc == vc.navigationController) {
            routerNC = nc;
        }else if (vc.navigationController){
            routerNC = vc.navigationController;
        }else{
            routerNC = nc;
        }
        if ([routerNC isKindOfClass:[UINavigationController class]]) {
            [routerNC pushViewController:vc animated:YES];
            if (notice) {
                [[NSNotificationCenter defaultCenter] postNotification:notice];
            }
        }
    } else {
        DLog(@"rootvc is not a nc or tc, cannot push");
    }
    return @[vc];
}

/**
 *  功能:执行host对应的函数
 */
- (id)p_routeNativeFuncWithHost:(NSString *)aHost params:(NSDictionary *)aParams{
    if ([aHost isEqualToString:@"back"]) {
        return [self routerBack];
    }
    OTSNativeFuncVO *nativeFuncVO = [self.nativeFuncMapping objectForCaseInsensitiveKey:aHost];
    if (!nativeFuncVO) {
        return nil;
    }
    return [self p_routeNativeFuncWithVO:nativeFuncVO params:aParams];
}

/**
 *  功能:执行OTSNativeFuncVO对应的函数
 */
- (id)p_routeNativeFuncWithVO:(OTSNativeFuncVO *)aVO params:(NSDictionary *)aParams{
    if (aVO.needLogin && ![OTSGlobalValue sharedInstance].token) {
        [self routerToLogin];
        return [NSNull null];
    }
    if (aVO.block) {
        return aVO.block(aParams);
    }else {
        return nil;
    }
}


@end
