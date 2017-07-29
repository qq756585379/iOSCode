//
//  SerialColorAndImageVO.m
//  GrouponProject
//
//  Created by meichun on 20-9-18.
//  Copyright (c) 2020年 OneStore. All rights reserved.
//

#import "GrouponSerialColorAndImageVO.h"


@implementation GrouponSerialColorAndImageVO

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.color forKey:@"color"];
    [aCoder encodeObject:self.defaultPicUrl forKey:@"defaultPicUrl"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.color = [aDecoder decodeObjectForKey:@"color"];
    self.defaultPicUrl = [aDecoder decodeObjectForKey:@"defaultPicUrl"];
    return self;
}

@end
