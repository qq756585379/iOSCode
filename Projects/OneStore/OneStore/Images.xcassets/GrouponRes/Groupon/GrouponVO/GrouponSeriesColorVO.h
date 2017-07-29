//
//  SeriesColorVO.h
//  TheStoreApp
//
//  Created by xuexiang on 12-12-31.
//
//

#import <Foundation/Foundation.h>

@interface GrouponSeriesColorVO : OTSValueObject

@property(nonatomic, copy) NSString *color;// 颜色ID
@property(nonatomic, copy) NSString *picUrl;// 图片地址

@end
