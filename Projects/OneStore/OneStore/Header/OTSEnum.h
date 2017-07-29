//
//  OTSEnum.h
//  OneStore
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

/**
 *  业务类型：注册
 */
typedef NS_ENUM(NSInteger, LoginType) {
    LoginTypeNormal,
    LoginTypeAutoLogin,
    LoginTypeQQ,
    LoginTypeWeiChat,
    LoginTypeSina,
    LoginTypeAlipay
};

//平台相关判断
typedef NS_ENUM(NSInteger, OTSPlatformType) {
    OTSPlatformTypePhone = 0,
    OTSPlatformTypePad   = 1,
};

typedef NS_ENUM(NSUInteger, OTSMappingClassCreateType){
    OTSMappingClassCreateByCode       = 0,//编码方式创建
    OTSMappingClassCreateByXib        = 1,//xib方式创建
    OTSMappingClassCreateByStoryboard = 2,//storyboard方式创建
};

typedef NS_ENUM(NSUInteger, OTSMappingClassPlatformType){
    OTSMappingClassPlatformTypePhone     = 0,//只在iPhone上load
    OTSMappingClassPlatformTypePad       = 1,//只在iPad上load
    OTSMappingClassPlatformTypeUniversal = 2,//任何平台都load
};

typedef NS_ENUM(NSUInteger, OTSNativeFuncVOPlatformType){
    OTSNativeFuncVOPlatformTypePhone     = 0,//只在iPhone上加载此func
    OTSNativeFuncVOPlatformTypePad       = 1,//只在iPad上加载此func
    OTSNativeFuncVOPlatformTypeUniversal = 2,//任何平台都加载此func
};






