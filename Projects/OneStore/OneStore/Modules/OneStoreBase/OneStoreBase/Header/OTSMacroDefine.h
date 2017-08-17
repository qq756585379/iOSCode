//
//  OTSMacroDefine.h
//  OneStore
//
//  Created by 杨俊 on 2017/8/17.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#define SHARED_APP_DELEGATE 			[UIApplication sharedApplication].delegate
#define SHARED_APP_TOP_WINDOW 			([UIApplication sharedApplication].keyWindow)
#define SHARED_APP_KEY_WINDOW_ROOT_VIEW ([UIApplication sharedApplication].keyWindow.rootViewController.view)

//property
#define OTS_PROPERTY(...) 	@property(nonatomic, ##__VA_ARGS__)
#define OTS_PROPERTY_STRONG OTS_PROPERTY(strong)
#define OTS_PROPERTY_ASSIGN OTS_PROPERTY(assign)
#define OTS_PROPERTY_WEAK   OTS_PROPERTY(weak)
#define OTS_PROPERTY_COPY   OTS_PROPERTY(copy)
