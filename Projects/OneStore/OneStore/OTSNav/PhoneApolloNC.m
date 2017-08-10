//
//  PhoneApolloNC.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/20.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "PhoneApolloNC.h"
#import "PhoneVC.h"
#import "NSObject+PerformBlock.h"

@interface PhoneApolloNC ()
@property (nonatomic, strong) NSArray *vcs;
@end

@implementation PhoneApolloNC

- (instancetype)init{
//        PhoneVC *homapageVC = [NSClassFromString(@"PhoneHomepageVC") createFromXib];
    PhoneVC *homapageVC  = [NSClassFromString(@"OTSHomepageVC") new];
    PhoneVC *apolloVC	 = [NSClassFromString(@"PhoneApolloVC") new];
    if (self = [super initWithRootViewController:homapageVC]) {
        self.vcs = @[homapageVC, apolloVC];
        [[OTSGlobalValue sharedInstance] addObserver:self forKeyPath:@"regionType"
                                             options:NSKeyValueObservingOptionInitial context:nil];
        [self updateRootVC:([OTSGlobalValue sharedInstance].regionType == OTSRegionTypeApollo)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    OTSGlobalValue *value = object;
    [self updateRootVC:(value.regionType == OTSRegionTypeApollo)];
}

- (void)updateRootVC:(BOOL)isInApollo{
    //for bug,need delay
    WEAK_SELF;
    self.view.userInteractionEnabled = NO;
    [self performInMainThreadBlock:^{
        STRONG_SELF;
        self.view.userInteractionEnabled = YES;
        [self switchToRootVC:self.vcs[isInApollo]];
    } afterSecond:.5f];
}

- (void)dealloc{
    [[OTSGlobalValue sharedInstance] removeObserver:self forKeyPath:@"inApollo"];
}
@end
