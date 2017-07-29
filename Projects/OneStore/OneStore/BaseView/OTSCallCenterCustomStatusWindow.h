//
//  OTSCallCenterCustomStatusWindow.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/19.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTSCallCenterCustomStatusWindow : UIWindow

@property (nonatomic, strong) NSDictionary *csrDict;

/**
 是否可以展示。
 YES:就正常展示信息
 NO:即时有信息也不展示
 */
@property (nonatomic, assign) BOOL canShow;

- (void)showMessage;
- (void)hideMessage;

@end
