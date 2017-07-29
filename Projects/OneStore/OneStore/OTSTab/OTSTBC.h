//
//  OTSTBC.h
//  OneStore
//
//  Created by yangjun on 2017/5/11.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTSTBC : UITabBarController <UITabBarControllerDelegate>

/**
 *  更新某个index的tab
 */
- (void)updateViewController:(UIViewController *)aVC atIndex:(NSUInteger)aIndex;

@end
