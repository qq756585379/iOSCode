//
//  OTSBlock.h
//  OneStore
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

typedef void(^LoginCompletionBlock)(NSError *error);

typedef void(^OTSNoParamNoReturnBlock)(void);

typedef void(^OTSIndexAndValueNoReturnBlock)(NSUInteger index, id value);

typedef id (^OTSNativeFuncVOBlock)(NSDictionary *params);

typedef void(^OTSCompletionBlock)(id aResponseObject, NSError* anError);
  
