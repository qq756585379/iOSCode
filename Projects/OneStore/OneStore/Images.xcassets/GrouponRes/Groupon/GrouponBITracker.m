//
//  GrouponBITracker.m
//  GrouponProject
//
//  Created by Vect Xi on 11/14/14.
//  Copyright (c) 2014 OneStore. All rights reserved.
//

#import "GrouponBITracker.h"

NSString *const GrouponHomeBI_ID = @"40000";
NSString *const GrouponProductListBI_ID = @"43000";
NSString *const GrouponProductDetailBI_ID = @"46000";
NSString *const GrouponTodayProductListBI_ID = @"42000";
NSString *const GrouponCommingBI_ID = @"41000";
NSString *const GrouponBrandHomeBI_ID = @"44000";
NSString *const GrouponBrandCategoryBI_ID = @"44100";
NSString *const GrouponBrandDetailBI_ID = @"45000";
NSString *const GrouponProductSeriealsBI_ID = @"47000";
NSString *const GrouponCheckOrderBI_ID = @"48000";


@implementation GrouponBITracker

+ (void)sendTracker:(OTSBITrackerBDPramaVO *)tracker {
    if (tracker) {
        if (tracker.b_pyi == nil) {
            tracker.b_pyi = @"1";
        }
        [[self sharedInstance] sendTracker:nil fromPage:nil withBdVO:tracker];
    }
}

+ (OTSBITrackerBDPramaVO *)trackerparamWithPageId:(NSString *)pageId {
    OTSBITrackerBDPramaVO *tracker = [[OTSBITrackerBDPramaVO alloc] init];
    tracker.w_pt = pageId;
    return tracker;
}

+ (OTSBITrackerBDPramaVO *)trackerparamWithPageId:(NSString *)pageId
                                              tpa:(NSString *)tpa
                                              tpi:(NSString *)tpi
{
    OTSBITrackerBDPramaVO *tracker = [self trackerparamWithPageId:pageId];
    tracker.w_tpa = tpa;
    tracker.w_tpi = tpi;
    return tracker;
}

@end
