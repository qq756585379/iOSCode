//
//  OTSVCAnimation.h
//  OneStoreFramework
//
//  Created by Aimy on 4/9/15.
//  Copyright (c) 2015 OneStore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTSVCAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, readonly, getter=isPush) BOOL push;

+ (instancetype)animationWithType:(BOOL)push;

@end
