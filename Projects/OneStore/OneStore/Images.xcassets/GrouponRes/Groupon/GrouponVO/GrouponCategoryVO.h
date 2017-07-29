//
//  GrouponCategory.h
//  GrouponProject
//
//  Created by Vect Xi on 9/29/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "OTSValueObject.h"

@interface GrouponCategoryVO : OTSValueObject

@property (nonatomic) NSInteger count;
@property (nonatomic) NSInteger nid;
@property (nonatomic, copy) NSString *name;

@end
