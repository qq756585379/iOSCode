//
//  SeriesProductVO.h
//  TheStoreApp
//
//  Created by xuexiang on 12-11-30.
//
//

#import <Foundation/Foundation.h>
#import "ProductVO.h"
#import "GrouponSerialAttributeVO.h"

@protocol GrouponSeriesProductVO <NSObject>

@end
@interface GrouponSeriesProductVO : OTSValueObject<NSCoding>

@property(nonatomic, retain) NSNumber *mainProductID;//主系列商品ID
@property(nonatomic, retain) NSNumber *subProductID;//子系列商品Id
@property(nonatomic, strong) NSNumber *pmId;//子序列商品的pmId
@property(nonatomic, retain) ProductVO *productVO;//子系列商品信息
@property(nonatomic, retain) NSString *productColor;//产品颜色
@property(nonatomic, retain) NSString *productSize;//产品尺寸

@property(nonatomic, strong) NSMutableArray<GrouponSeriesAttributeVO> *seriesAttributeVOList; //序列属性 List<SerialAttributeVO.h>
/**
 * 是否可售： 0：不可售  1：可售
 * 不可售的情况：库存为0、商品不可销可见
 */
@property(nonatomic, retain) NSNumber *isCanSale;

/**
 *	功能:商品是否可售
 *
 *	@return
 */
- (BOOL)isSale;
- (NSDictionary*)serAttrMap;
- (NSString *)serialToString;
- (NSNumber*)getPmidInySeriesProductVOList:(NSArray*)seriesProductVOList;
@end
