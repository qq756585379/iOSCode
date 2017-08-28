//
//  OTSOperationParam.h
//  OneStore
//
//  Created by 杨俊 on 2017/8/14.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "OTSBlock.h"

typedef enum {
    kRequestPost = 0,                   //post方式
    kRequestGet                         //get方式
} ERequestType;

typedef NS_ENUM(NSInteger, EUpLoadFileType){
    kUpLoadData = 0,                    //data方式
    kUpLoadUrl                          //url方式
};

typedef NS_ENUM(NSInteger, EUpLoadFileMimeType){
    kPng = 0,                           //png方式
    kJpg                                //jpg方式
};

@interface OTSOperationParam : NSObject

@property(nonatomic, assign) BOOL needSignature;                        //是否需要签名，默认为YES
@property(nonatomic, assign) BOOL needEncoderToken;                     //是否加密token，默认为YES
@property(nonatomic, assign) BOOL needCooike;                           //是否需要cooike,默认为NO
@property(nonatomic, assign) NSInteger retryTimes;                      //重试次数，默认为1
@property(nonatomic, assign) NSTimeInterval cacheTime;                  //缓存时间，默认为0秒
@property(nonatomic, assign) NSTimeInterval timeoutTime;                //超时时间，默认为10秒
@property(nonatomic, assign) BOOL alertError;                           //是否弹出错误提示，默认为NO
@property(nonatomic, assign) BOOL showErrorView;                        //是否显示错误界面，默认为NO
@property(nonatomic,   copy) OTSCompletionBlock callbackBlock;            //回调block
#pragma mark - 拼装requestUrl相关
@property(nonatomic, copy) NSString *methodName;                        //方法名
@property(nonatomic, copy) NSString *businessName;                      //业务名
@property(nonatomic, copy) NSString *versionNum;                        //版本，如"v2.3"
#pragma mark - 接口调用相关
@property(nonatomic, copy) NSString *requestUrl;                        //请求url
@property(nonatomic, assign) ERequestType requestType;                  //请求类型，post还是get方式，默认为post方式
@property(nonatomic, strong) NSDictionary *requestParam;                //参数
#pragma mark - 接口错误相关
@property(nonatomic, assign) BOOL rerunForTokenExpire;                  //是否token过期自动登录后再次执行，默认为NO
@property(nonatomic, assign) BOOL rerunForSignKeyExpire;                //是否重新调用获取密钥接口后再次执行，默认为NO
@property(nonatomic, assign) BOOL rerunForLaunchFail;                   //是否重新调用启动接口后再次执行，默认为NO
@property(nonatomic, copy) NSString *usedToken;                         //记录当前请求使用的token
@property(nonatomic, copy) NSString *usedIp;                            //记录当前请求使用的ip
@property(nonatomic, assign) BOOL needUseIp;                            //是否需要使用ip，默认为NO
#pragma mark - 接口日志相关
@property(nonatomic, assign) NSTimeInterval startTimeStamp;             //接口调用开始时间，精确到ms
@property(nonatomic, assign) NSTimeInterval endTimeStamp;               //接口调用结束时间，精确到ms
@property(nonatomic, assign) NSInteger errorType;                       //接口错误类型(0无错误，1接口超时，2接口出错，3rtn_code不为0)
@property(nonatomic, strong) NSString *errorCode;                       //接口错误码
#pragma mark - RACReuqest
@property (nonatomic, strong) id<RACSubscriber> subscriber; //网络请求的信号订阅者

@property (nonatomic, assign) BOOL isNeedRacRequest; //是否使用rac方法请求数据
/**
 *  YES:暂时不向订阅的信号发送错误事件.
 *  订阅者发送了错误事件,这个订阅者就会被销毁.重试时就没办法再给信号发送其他事件了
 *
 */
@property (nonatomic, assign) BOOL blockSendError;

/**
 *  功能:初始化方法
 */
+ (instancetype)paramWithBusinessName:(NSString *)aBusinessName
                           methodName:(NSString *)aMethodName
                           versionNum:(NSString *)aVersionNum
                                 type:(ERequestType)aType
                                param:(NSDictionary *)aParam
                             callback:(OTSCompletionBlock)aCallback;

/**
 *  功能:初始化方法
 */
+ (instancetype)paramWithUrl:(NSString *)aUrl
                        type:(ERequestType)aType
                       param:(NSDictionary *)aParam
                    callback:(OTSCompletionBlock)aCallback;

@end
