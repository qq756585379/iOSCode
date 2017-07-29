//
//  GrouponOrderSubmitResult.h
//  TheStoreApp
//


#import <Foundation/Foundation.h>

@interface GrouponOrderSubmitResult : OTSValueObject

@property(nonatomic, retain) NSNumber *orderId;//订单id
@property(nonatomic, retain) NSNumber *hasError;//是否有错误
@property(nonatomic, retain) NSString *errorInfo;//错误提示信息
@property(nonatomic, retain) NSString *orderCode;
@property(nonatomic, retain) NSNumber *orderAmount;
@property(nonatomic, retain) NSNumber *orderClientType;
@property(nonatomic, retain) NSDate   *orderCreateTime;

@end
