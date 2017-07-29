//
//  ProductRatingVO.m
//  ProtocolDemo
//
//  Created by vsc on 11-1-19.
//  Copyright 2011 vsc. All rights reserved.
//

#import "GrouponProductRatingVO.h"


@implementation GrouponProductRatingVO

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.badExperiencesCount forKey:@"badExperiencesCount"];
    [aCoder encodeObject:self.badRating forKey:@"badRating"];
    [aCoder encodeObject:self.goodExperiencesCount forKey:@"goodExperiencesCount"];
    [aCoder encodeObject:self.goodRating forKey:@"goodRating"];
    [aCoder encodeObject:self.middleExperiencesCount forKey:@"middleExperiencesCount"];
    [aCoder encodeObject:self.middleRating forKey:@"middleRating"];
    [aCoder encodeObject:self.top5Experience forKey:@"top5Experience"];
    [aCoder encodeObject:self.totalExperiencesCount forKey:@"totalExperiencesCount"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.badExperiencesCount = [aDecoder decodeObjectForKey:@"badExperiencesCount"];
    self.badRating = [aDecoder decodeObjectForKey:@"badRating"];
    self.goodExperiencesCount = [aDecoder decodeObjectForKey:@"goodExperiencesCount"];
    self.goodRating = [aDecoder decodeObjectForKey:@"goodRating"];
    self.middleExperiencesCount = [aDecoder decodeObjectForKey:@"middleExperiencesCount"];
    self.middleRating = [aDecoder decodeObjectForKey:@"middleRating"];
    self.top5Experience = [aDecoder decodeObjectForKey:@"top5Experience"];
    self.totalExperiencesCount = [aDecoder decodeObjectForKey:@"totalExperiencesCount"];
    return self;
}
@end
