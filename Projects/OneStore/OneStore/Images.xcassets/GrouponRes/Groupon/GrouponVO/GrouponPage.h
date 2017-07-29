//
//  GrouponPage.h
//  GrouponProject
//
//  Created by Vect Xi on 11/5/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "OTSValueObject.h"

@protocol GrouponVO;

@interface GrouponPage : OTSValueObject

@property (nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSMutableArray<GrouponVO> *objList;
@property (nonatomic) NSInteger pageSize;
@property (nonatomic) NSInteger totalSize;


@end
