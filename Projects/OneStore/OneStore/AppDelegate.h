//
//  AppDelegate.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/17.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTSWindow.h"
#import "OTSCallCenterCustomStatusWindow.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
    
@property (nonatomic, strong) OTSWindow *window;
@property (nonatomic, strong) OTSWindow *pcWindow;
@property (nonatomic, strong) OTSWindow *topWindow;
@property (nonatomic, strong) OTSCallCenterCustomStatusWindow *globalMessageWindow;

- (void)endEditing;
    
@end


