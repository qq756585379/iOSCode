//
//  PhoneCustomRootNC.m
//  OneStore
//
//  Created by 杨俊 on 2017/7/20.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "PhoneCustomRootNC.h"
#import "UIViewController+router.h"

@interface PhoneCustomRootNC ()

@end

@implementation PhoneCustomRootNC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (instancetype)createWithUrlString:(NSString *)aUrl{
    PhoneTabBarItem *item = (id)self.tabbarItem;
    
    if (!aUrl.length) {
        OTSMappingVO *vo = [[OTSRouter singletonInstance] mapping][item.defaultVO.hostString];
        UIViewController *vc = [UIViewController createWithMappingVO:vo extraData:nil];
        PhoneCustomRootNC *nc = [[PhoneCustomRootNC alloc] initWithRootViewController:vc];
        return nc;
    }
    
    NSURL *url = [NSURL URLWithString:aUrl.urlEncoding];
    
    if ([url.scheme isEqualToString:@"http"] || [url.scheme isEqualToString:@"https"]) {
        OTSMappingVO *vo = [[OTSRouter singletonInstance] mapping][@"web"];
        NSDictionary *params = @{@"url": url.absoluteString};
        UIViewController *vc = [UIViewController createWithMappingVO:vo extraData:params];
        if (vc) {
            [item setHostString:@"web"];
            PhoneCustomRootNC *nc = [[PhoneCustomRootNC alloc] initWithRootViewController:vc];
            vc.edgesForExtendedLayout =UIRectEdgeNone;
            return nc;
        }
        DLog(@"切换的url不能创建webview %@",aUrl);
        return self;
    }
    
    NSMutableDictionary *params = ((NSDictionary *)([NSString getDictFromJsonString:url.query][OTSRouterParamKey])).mutableCopy;
    params[OTSRouterFromHostKey] = url.host;
    params[OTSRouterFromSchemeKey] = url.scheme;
    
    OTSMappingVO *vo = [[OTSRouter singletonInstance] mapping][url.host];
    UIViewController *vc = [UIViewController createWithMappingVO:vo extraData:params];
    
    if (vc) {
        [item setHostString:url.host];
        PhoneCustomRootNC *nc = [[PhoneCustomRootNC alloc] initWithRootViewController:vc];
        vc.edgesForExtendedLayout =UIRectEdgeNone;
        return nc;
    }else {
        item.hostString = item.defaultVO.hostString;
        OTSMappingVO *vo = [[OTSRouter singletonInstance] mapping][item.defaultVO.hostString];
        UIViewController *vc = [UIViewController createWithMappingVO:vo extraData:nil];
        PhoneCustomRootNC *nc = [[PhoneCustomRootNC alloc] initWithRootViewController:vc];
        vc.edgesForExtendedLayout =UIRectEdgeNone;
        return nc;
    }
}

@end
