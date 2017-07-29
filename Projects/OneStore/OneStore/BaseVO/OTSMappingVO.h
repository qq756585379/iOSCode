//
//  OTSMappingVO.h
//  OneStore
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTSEnum.h"

@interface OTSMappingVO : NSObject
/**
 *  创建的类名
 */
@property (nonatomic, strong) NSString *className;
/**
 *  创建的方式
 */
@property (nonatomic) OTSMappingClassCreateType createdType;
/**
 *  load过滤
 */
@property (nonatomic) OTSMappingClassPlatformType loadFilterType;
/**
 *  资源文件名称
 */
@property (nonatomic, strong) NSString *nibName;
/**
 *  storyboard名称
 */
@property (nonatomic, strong) NSString *storyboardName;
/**
 *  storyboard中storyboardID名称
 */
@property (nonatomic, strong) NSString *storyboardID;
/**
 *  进入此界面需要先登陆
 */
@property (nonatomic) BOOL needLogin;

@end
