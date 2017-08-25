//
//  OTSAntiBrushError.h
//  OneStoreNetwork
//
//  Created by huangjiming on 12/24/15.
//  Copyright © 2015 OneStoreNetwork. All rights reserved.
//

#import "OTSNetworkError.h"

typedef void(^OTSAntiBrushErrorHandleBlock)(id aResponseObject);

@interface OTSAntiBrushError : OTSNetworkError

AS_SINGLETON(OTSAntiBrushError)

@property(nonatomic, copy) OTSAntiBrushErrorHandleBlock antiBrushErrorHandleBlock;//防刷错误处理block

/**
 *  功能:添加防刷rtn_code
 */
- (void)addAntiBrushRtnCode:(NSString *)aRtnCode;

@end
