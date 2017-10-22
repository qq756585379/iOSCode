//
//  YJTabBarVC.h
//  TZTV
//
//  Created by Luosa on 2016/11/9.
//  Copyright © 2016年 Luosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJTabBarVC : UITabBarController

/**
 *  更新某个index的tab
 */
- (void)updateViewController:(UIViewController *)aVC atIndex:(NSUInteger)aIndex;

@end
