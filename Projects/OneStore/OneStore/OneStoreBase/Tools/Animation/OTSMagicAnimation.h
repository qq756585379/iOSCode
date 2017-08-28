//
//  OTSMagicAnimation.h
//  OneStoreFramework
//
//  Created by Aimy on 4/9/15.
//  Copyright (c) 2015 OneStore. All rights reserved.
//

#import "OTSVCAnimation.h"

@interface OTSMagicAnimation : OTSVCAnimation

@end

@interface UIViewController (OTSMagicAnimation)

//需要转换的view
- (NSArray *)animationViews;

@end