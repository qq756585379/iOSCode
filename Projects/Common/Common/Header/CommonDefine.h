//
//  CommonDefine.h
//  Common
//
//  Created by yangjun on 2017/5/8.
//  Copyright © 2017年 yangjun. All rights reserved.
//

/***********屏幕适配*************/
#define SCREEN_WIDTH 		([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT 		([UIScreen mainScreen].bounds.size.height)
#define kTabBarH       		49.0f
#define kStatusBarH     	20.0f
#define kNavigationBarH		44.0f
#define iphone6P       		(SCREEN_HEIGHT == 736)
#define iphone6         	(SCREEN_HEIGHT == 667)
#define iphone5         	(SCREEN_HEIGHT == 568)
#define iphone4         	(SCREEN_HEIGHT == 480)
/***********屏幕适配*************/

// 单例
#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once(&once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

/**快速创建弱指针*/
#define WEAK_SELF    __weak typeof(self)weakSelf = self;
#define STRONG_SELF  __strong typeof(weakSelf)self = weakSelf;


#define kAppDelegate            [[UIApplication sharedApplication] delegate]
#define kWindow                 [[UIApplication sharedApplication] keyWindow]
//字体
#define YJFont(size)            [UIFont systemFontOfSize:size]
#define YJBoldFont(size)        [UIFont boldSystemFontOfSize:size]

//判断设备
#define IS_IPAD_DEVICE 		(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE_DEVICE 	(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


#define kDEVICE_MODEL  		 [[UIDevice currentDevice] model]
#define kAPP_NAME            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define kAPP_VERSION         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define kAPP_SUB_VERSION     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define IOS_VERSION 		 [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
#define CurrentLanguage 	 ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断ios版本
#define IOS_SDK_MORE_THAN_OR_EQUAL(__num) [UIDevice currentDevice].systemVersion.floatValue >= (__num)
#define IOS_SDK_MORE_THAN(__num) [UIDevice currentDevice].systemVersion.floatValue > (__num)
#define IOS_SDK_LESS_THAN(__num) [UIDevice currentDevice].systemVersion.floatValue < (__num)

//判断横竖屏
#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)

//判空
#define StringNotEmpty(str)  (str && (str.length > 0))
#define ArrayNotEmpty(arr)   (arr && (arr.count > 0))

#define ISIPHONE3_5  CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size)
#define ISIPHONE4_0  CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size)
#define ISIPHONE4_7  CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size)
#define ISIPHONE5_5  CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size)
#define ISIPHONE9_7  CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] bounds].size)
#define ISIPHONE9_7_LAND  CGSizeEqualToSize(CGSizeMake(1024, 768), [[UIScreen mainScreen] bounds].size)







