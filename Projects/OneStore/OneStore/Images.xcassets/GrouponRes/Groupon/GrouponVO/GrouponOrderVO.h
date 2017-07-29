//
//  GrouponOrderVO.h
//  TheStoreApp
//
//  Created by jiming huang on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "GoodReceiver.h"
#import "GrouponVO.h"
#import "GrouponUserVO.h"
#import "GrouponOrderV2.h"

@interface GrouponOrderVO : OTSValueObject

@property(nonatomic, retain) GrouponVO *grouponVO;//团购信息
@property(nonatomic, retain) GrouponUserVO *userVO;//用户信息
@property(nonatomic, retain) NSArray *pmVOList;//支付方式信息，list<PaymentMethodVO>
@property(nonatomic, retain) GrouponOrderV2 *orderVO;//订单信息
@property(nonatomic, retain) NSNumber *hasError;//是否有校验错误
@property(nonatomic, retain) NSString *errorInfo;//错误提示信息

@end
