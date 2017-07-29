//
//  GrouponSerialVO.m
//  GrouponProject
//
//  Created by meichun on 20-9-18.
//  Copyright (c) 2020年 OneStore. All rights reserved.
//

#import "GrouponSerialVO.h"



#import "GrouponSerialVO.h"

@implementation GrouponSerialVO

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.nid forKey:@"nid"];
    [aCoder encodeObject:self.grouponId forKey:@"grouponId"];
    [aCoder encodeObject:self.mainProductId forKey:@"mainProductId"];
    [aCoder encodeObject:self.subProductId forKey:@"subProductId"];
    [aCoder encodeObject:self.productColor forKey:@"productColor"];
    [aCoder encodeObject:self.productSize forKey:@"productSize"];
    [aCoder encodeObject:self.upperSaleNum forKey:@"upperSaleNum"];
    [aCoder encodeObject:self.boughtNum forKey:@"boughtNum"];
    [aCoder encodeObject:self.pmId forKey:@"pmId"];
    [aCoder encodeObject:self.stockAvailable forKey:@"stockAvailable"];
    [aCoder encodeObject:self.price forKey:@"pirce"];
    [aCoder encodeObject:self.channelId forKey:@"channelId"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.nid = [aDecoder decodeObjectForKey:@"nid"];
    self.grouponId = [aDecoder decodeObjectForKey:@"grouponId"];
    self.mainProductId = [aDecoder decodeObjectForKey:@"mainProductId"];
    self.subProductId = [aDecoder decodeObjectForKey:@"subProductId"];
    self.productColor = [aDecoder decodeObjectForKey:@"productColor"];
    self.productSize = [aDecoder decodeObjectForKey:@"productSize"];
    self.upperSaleNum = [aDecoder decodeObjectForKey:@"upperSaleNum"];
    self.boughtNum = [aDecoder decodeObjectForKey:@"boughtNum"];
    self.pmId = [aDecoder decodeObjectForKey:@"pmId"];
    self.stockAvailable = [aDecoder decodeObjectForKey:@"stockAvailable"];
    self.price = [aDecoder decodeObjectForKey:@"price"];
    self.channelId = [aDecoder decodeObjectForKey:@"channelId"];
    return self;
}

- (BOOL)isWirelessExclusivePirce
{
    if (self.channelId.integerValue == 102) {
        return YES;
    }
    return NO;
}
@end


