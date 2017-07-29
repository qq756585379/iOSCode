//
//  OTSConst.h
//  OneStore
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

static NSString *const BusinessName = @"passport";
static NSString *const KeychainAccount = @"keychain.pasport.account";

static NSString *const UserDefaultUnionLogin = @"userdefault.passport.unionLogin";
static NSString *const UserDefaultAUT = @"userdefault.passport.aut";

static NSString *const OTSPassportInterfaceErrorDomain = @"error.passport.interface";

// Error message
static NSString *const ErrorAccountNil = @"请输入账号";
static NSString *const ErrorPasswordNil = @"请输入密码";

static NSString *const NotificationLogin = @"notification.passport.login";
static NSString *const NotificationLoginFailed = @"notificatoin.passport.loginfailed";
static NSString *const NotificationLogout = @"notification.passport.logout";

static NSString *const PassportBusinessTypeRegister = @"register";
static NSString *const PassportBusinessTypeEdit = @"yhd_edit_order";//修改订单发送验证码接口

static NSString *const OTSRouterCallbackKey = @"routercallback";
static NSString *const OTSRouterParamKey = @"body";

static NSString *const OTSRouterFromHostKey = @"OTSRouterFromHostKey";
static NSString *const OTSRouterFromSchemeKey = @"OTSRouterFromSchemeKey";
