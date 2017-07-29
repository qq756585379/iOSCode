//
//  OrderV2.m
//  TheStoreApp
//
//  Created by yangxd on 11-6-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GrouponOrderV2.h"
#import "OTSGlobalValue.h"
#import "GrouponOrderVO.h"
#import <objc/runtime.h>

@implementation GrouponOrderV2

@synthesize currentBrank = _currentBrank;

- (id)initWithOrderVO:(GrouponOrderVO *)anOrderVO
{
    self = [super init];
    if (self && anOrderVO)
    {
        int i;
        unsigned int propertyCount = 0;
        objc_property_t *propertyList = class_copyPropertyList([anOrderVO class], &propertyCount);
        
        for (i = 0; i < propertyCount; i++) {
            objc_property_t *thisProperty = propertyList + i;
            const char *propertyName = property_getName(*thisProperty);
            NSLog(@"Person has a property: '%s'", propertyName);
            
            NSString *propertyStr = [[NSString alloc] initWithCString:propertyName encoding:NSUTF8StringEncoding];
            if (propertyStr) {
                id value = [anOrderVO valueForKey:propertyStr];
                if (value) {
                    [self setValue:value forKey:propertyStr];
                }
            }
        }
    }
    
    return self;
}

- (BOOL )isCanChangePayWay
{
//	if([OTSGlobalValue sharedInstance].isLoginFromAliPay
//	   && [self.mobileBank.name isEqualToString:@"支付宝客户端支付"]){
//		return NO;
//	}
	return YES;
}

- (BOOL)isGiftCard
{
	return self.isEleGitfCardOrder.boolValue;
}

- (BOOL)isEntityGiftCard
{
	if (self.isGiftCardOrder.boolValue && !self.isEleGitfCardOrder.boolValue) {
		return YES;
	}
	return NO;
}

- (BOOL)isComment
{
	if (self.commentState.integerValue == 1) {
		return  YES;
	}
	return NO;
}

//- (NSString *)paymentMethodForString
//{
//	NSString *paymentMethodStr = @"";
//	if (_paymentMethodForString.length > 0) {
//		paymentMethodStr = _paymentMethodForString;
//	}
//
//	if (self.currentBrank) {
//		paymentMethodStr = self.currentBrank.name;
//	}
//	return paymentMethodStr;
//}

- (void)setBankList:(NSArray<GrouponMobileBank> *)bankList
{
	if (_bankList != bankList) {
		_bankList = bankList;
		//列表更新时，当前选中的银行也要更新
		_currentBrank = nil;
	}
}
- (void )setCurrentBrank:(GrouponMobileBank *)currentBrank
{
	if (_currentBrank != currentBrank ) {
		_currentBrank = currentBrank;
		self.gateway = _currentBrank.nid;
		self.gatewayName = _currentBrank.name;
//		self.paymentMethodForString = _currentBrank.name;
	}
}
- (GrouponMobileBank *)currentBrank
{
	if (_currentBrank == nil) {
		for (GrouponMobileBank *bank in self.bankList) {
			if (self.gateway.integerValue == bank.nid.integerValue) {
				_currentBrank = bank;
				break;
			}
		}
	}
	return _currentBrank;
}

- (BOOL)isPaySuccess
{
	if(self.orderStatus.intValue == 34
	   || self.orderPaymentSignal.boolValue
	   || [self.paymentMethodForString isEqualToString:@"货到付款"]
	   || [self.paymentMethodForString isEqualToString:@"pos机"]){
		_isPaySuccess = YES;
	}
	return _isPaySuccess;
}

- (BOOL) isBankTransferOrder
{
	if ([self.paymentMethodForString isEqualToString:@"银行转账"]) {
		return YES;
	}
	return NO;
}
@end
