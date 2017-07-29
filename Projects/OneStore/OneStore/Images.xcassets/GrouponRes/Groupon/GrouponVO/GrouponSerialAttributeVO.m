//
//  SerialAttributeVO.m
//  OneStore
//
//  Created by yuan jun on 14-5-21.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "GrouponSerialAttributeVO.h"

@implementation GrouponSeriesAttributeVO

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.attributeId forKey:@"attributeId"];
    [aCoder encodeObject:self.attributeValueId forKey:@"attributeValueId"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.attributeId = [aDecoder decodeObjectForKey:@"attributeId"];
    self.attributeValueId = [aDecoder decodeObjectForKey:@"attributeValueId"];
    
    return self;
}

@end
