//
//  OTSValueObject.h
//  OneStoreFramework
//
//  Created by Aimy on 9/15/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "JSONModel.h"

@interface OTSValueObject : JSONModel
/**
 *  通过字典创建VO
 *
 *  @param aDict 字典
 *
 *  @return VO
 */
+ (instancetype)voWithDict:(NSDictionary *)aDict;

@end
