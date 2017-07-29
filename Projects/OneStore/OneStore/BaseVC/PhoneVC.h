//
//  PhoneVC.h
//  OneStore
//
//  Created by 杨俊 on 2017/7/20.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OTSVC.h"

@interface PhoneVC : OTSVC
{
    NSString *aaa;
}
/**
 *  显示悬浮购物车
 */
@property (nonatomic) BOOL showBuoyCart;

/**
 *  显示红包入口弹窗
 */
@property (nonatomic) BOOL showRedBagEntranceView;

/**
 *  立即显示或者隐藏悬浮购物车
 */
- (void)setBuoyCartHidden:(BOOL)hidden;

/**
 *  功能:显示空态view
 *  aFrame:传入CGRectZero时，空态页面大小等于aView.bounds
 */
- (void)showNilViewInView:(UIView *)aView
                    frame:(CGRect)aFrame
                  bgColor:(UIColor *)aColor
                      img:(UIImage *)aImg
                      tip:(NSString *)aTip
                 btnTitle:(NSString *)aTitle;

- (void)showNilViewInView:(UIView *)aView
                    frame:(CGRect)aFrame
                  bgColor:(UIColor *)aColor
                      img:(UIImage *)aImg
                  atriStr:(NSAttributedString *)atriStr
                 btnTitle:(NSString *)aTitle;

/**
 *  功能:隐藏空态view
 */
- (void)hideNilView;

@end
