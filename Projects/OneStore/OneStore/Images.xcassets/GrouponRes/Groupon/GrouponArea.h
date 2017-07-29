//
//  GrouponArea.h
//  GrouponProject
//
//  Created by Vect Xi on 9/29/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GrouponArea : NSObject

AS_SINGLETON(GrouponArea)

- (void)getAreaIdWithCompletionBlock:(void(^)(NSInteger areaId))aCompletionBlock;

@end
