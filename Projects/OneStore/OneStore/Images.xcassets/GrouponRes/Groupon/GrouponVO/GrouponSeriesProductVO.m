//
//  SeriesProductVO.m
//  TheStoreApp
//
//  Created by xuexiang on 12-11-30.
//
//

#import "GrouponSeriesProductVO.h"
#import "GrouponSerialAttributeVO.h"
@implementation GrouponSeriesProductVO

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.mainProductID forKey:@"mainProductID"];
    [aCoder encodeObject:self.subProductID forKey:@"subProductID"];
    [aCoder encodeObject:self.productVO forKey:@"productVO"];
    [aCoder encodeObject:self.productColor forKey:@"productColor"];
    [aCoder encodeObject:self.productSize forKey:@"productSize"];
	[aCoder encodeObject:self.isCanSale forKey:@"isCanSale"];
	[aCoder encodeObject:self.seriesAttributeVOList forKey:@"seriesAttributeVOList"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.mainProductID = [aDecoder decodeObjectForKey:@"mainProductID"];
    self.subProductID = [aDecoder decodeObjectForKey:@"subProductID"];
    self.productVO = [aDecoder decodeObjectForKey:@"productVO"];
    self.productColor = [aDecoder decodeObjectForKey:@"productColor"];
    self.productSize = [aDecoder decodeObjectForKey:@"productSize"];
	self.isCanSale = [aDecoder decodeObjectForKey:@"isCanSale"];
    self.seriesAttributeVOList = [aDecoder decodeObjectForKey:@"seriesAttributeVOList"];

    return self;
}

- (NSDictionary*)serAttrMap{
    
    
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    [dic setObject:self.pmId forKey:[self serialToString]];
    return dic;
}

- (NSString *)serialToString{
    [self.seriesAttributeVOList sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        GrouponSeriesAttributeVO *temp1 = obj1;
        GrouponSeriesAttributeVO *temp2 = obj2;
        if (temp1.attributeId.integerValue < temp2.attributeId.integerValue) {
            return NSOrderedAscending;
        }
        else if (temp1.attributeId.integerValue > temp2.attributeId.integerValue) {
            return NSOrderedDescending;
        }
        else {
            return NSOrderedSame;
        }
        
    }];
    NSMutableString *str=[[NSMutableString alloc] init];
    for (int i=0; i<self.seriesAttributeVOList.count; i++) {
        GrouponSeriesAttributeVO*attr=[self.seriesAttributeVOList safeObjectAtIndex:i];
        [str appendString:[NSString stringWithFormat:@"%@:%@ ",attr.attributeId,attr.attributeValueId]];
    }
    return str;
}

- (NSNumber*)getPmidInySeriesProductVOList:(NSArray*)seriesProductVOList{
    for (GrouponSeriesProductVO*po in seriesProductVOList) {
        NSNumber *pmid=[[po serAttrMap] valueForKey:[self serialToString]];
        if (pmid!=nil) {
            return pmid;
        }
    }
    return nil;
}
- (BOOL)isSale
{
	if (self.isCanSale && !self.isCanSale.boolValue) {
		return NO;
	}
	return YES;
}
@end
