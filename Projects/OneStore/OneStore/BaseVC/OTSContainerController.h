//
//  OTSContainerController.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTSContainerController : UIViewController

//call child view controllers life cycle methods
- (void)callChildVCsViewWillAppear:(BOOL)animated;
- (void)callChildVCsViewDidAppear:(BOOL)animated;
- (void)callChildVCsViewWillDisappear:(BOOL)animated;
- (void)callChildVCsViewDidDisappear:(BOOL)animated;

@end
