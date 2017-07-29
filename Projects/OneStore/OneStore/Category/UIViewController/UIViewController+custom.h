//
//  UIViewController+custom.h
//  Common
//
//  Created by 杨俊 on 2017/6/22.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NaviButtonType) {
    NaviButton_None = 0,        //空的，无图片
    NaviButton_Return,          //返回
    NaviButton_Return_white,    //返回，白色箭头
    NaviButton_Search,          //搜索
    NaviButton_ReturnHome,      //返回首页
    NaviButton_Setting,         //设置
    NaviButton_Favorite,        //收藏
    NaviButton_GrayShare,       //灰色分享
    NaviButton_RockNow,         //摇一摇
    NaviButton_Scan,            //扫描
    NaviButton_MessageCenter,   //消息中心
    NaviButton_WhiteBack,       //白色背景框
    NaviButton_Category,        //分类
    NaviButton_Logo,            //logo
    NaviButon_Brand_Category,   //品牌团分类选择
    NaviButton_Gray,            //灰色按钮
};

@interface OTSDataNaviBtn : UIButton
@property(nonatomic,   copy) NSString *href;
@property(nonatomic, strong) NSArray  *items;
@end

@interface OTSUpdownLayoutNaviBtn : OTSDataNaviBtn

@end

@interface UIViewController (custom)

/**
 *  功能:设置左按钮的类型（图片）
 *
 *  @param aType  按钮类型
 *  @param aFrame 图片大小(理论上只需要设置size就行)
 */
- (void)setNaviButtonType:(NaviButtonType)aType frame:(CGRect)aFrame;

/**
 *  功能:设置左按钮的类型（图片+文字）
 *  type:按钮类型  aFrame:大小  text:文字   color:颜色  font:样式
 */
- (void)setNaviButtonType:(NaviButtonType)aType
                    frame:(CGRect)aFrame
                     text:(NSString *)aText
                    color:(UIColor *)aColor
                     font:(UIFont *)aFont;

- (void)setNaviButtonType:(NaviButtonType)aType
                  isBgImg:(BOOL)aIsBgImg
                    frame:(CGRect)aFrame
                     text:(NSString *)aText
                    color:(UIColor *)aColor
                     font:(UIFont *)aFont
             shadowOffset:(CGSize)aShadowOffset
                alignment:(UIControlContentHorizontalAlignment)aAlignment
               edgeInsets:(UIEdgeInsets)aEdgeInsets
                   isLeft:(BOOL)aLeft;


/**
 *  功能:设置左/右按钮的类型（图片）和文字（包括颜色大小样式）
 *  type:按钮类型   text:文字   color:颜色  font:样式   alignment:对齐方式  edgeInsets:边距 shadowOffset:阴影偏移量  aLeft:是否是左按钮
 */
- (void)setNaviButtonType:(NaviButtonType)aType
                    frame:(CGRect)aFrame
                     text:(NSString *)aText
                    color:(UIColor *)aColor
                     font:(UIFont *)aFont
             shadowOffset:(CGSize)aShadowOffset
                alignment:(UIControlContentHorizontalAlignment)aAlignment
               edgeInsets:(UIEdgeInsets)aEdgeInsets
                   isLeft:(BOOL)aLeft;

/**
 *  功能:设置左按钮类型（图片）
 *  type:按钮类型
 */
- (void)setNaviButtonType:(NaviButtonType)aType isLeft:(BOOL)aLeft;

/**
 *  功能:设置按钮文字
 *  aText:按钮文字
 */
- (void)setNaviButtonText:(NSString *)aText isLeft:(BOOL)aLeft;

/**
 *  功能:上下布局的按钮，上面图片，下面文字
 */
- (void)setUpdownLayoutNaviButtonType:(NaviButtonType)aType text:(NSString *)aText
                                 href:(NSString *)aHref items:(NSArray *)aItems isLeft:(BOOL)aLeft;

/**
 *  功能:左按钮点击行为，可在子类重写此方法
 */
- (void)leftBtnClicked:(id)sender;

/**
 *  功能:右按钮点击行为，可在子类重写此方法
 */
- (void)rightBtnClicked:(id)sender;

@end



















