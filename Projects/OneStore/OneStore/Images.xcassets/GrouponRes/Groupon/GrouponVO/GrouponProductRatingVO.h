//
//  ProductRatingVO.h
//  ProtocolDemo
//
//  Created by vsc on 11-1-19.
//  Copyright 2011 vsc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GrouponProductRatingVO : OTSValueObject<NSCoding>

@property(retain, nonatomic) NSNumber *badExperiencesCount;
@property(retain, nonatomic) NSNumber *badRating;
@property(retain, nonatomic) NSNumber *goodExperiencesCount;
@property(retain, nonatomic) NSNumber *goodRating;
@property(retain, nonatomic) NSNumber *middleExperiencesCount;
@property(retain, nonatomic) NSNumber *middleRating;
@property(retain, nonatomic) NSMutableArray *top5Experience;//list<ProductExperienceVO>
@property(retain, nonatomic) NSNumber *totalExperiencesCount;

@end
