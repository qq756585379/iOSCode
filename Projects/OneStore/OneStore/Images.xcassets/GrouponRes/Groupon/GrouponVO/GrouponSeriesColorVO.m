//
//  SeriesColorVO.m
//  TheStoreApp
//
//  Created by xuexiang on 12-12-31.
//
//

#import "GrouponSeriesColorVO.h"

@implementation GrouponSeriesColorVO
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.color forKey:@"color"];
    [aCoder encodeObject:self.picUrl forKey:@"picUrl"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.picUrl = [aDecoder decodeObjectForKey:@"picUrl"];
    self.color = [aDecoder decodeObjectForKey:@"color"];
    return self;

}
@end
