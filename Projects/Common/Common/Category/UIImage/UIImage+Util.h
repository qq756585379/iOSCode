//
//  UIImage+Util.h
//  MiHome
//
//  Created by yangjun on 2017/4/26.
//  Copyright © 2017年 小米移动软件. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)

//圆形图片
-(UIImage *)circleImage;
-(UIImage *)circleImage2;
+(UIImage *)imageWithColor:(UIColor *)aColor;
+(UIImage *)imageWithColor:(UIColor *)aColor andSize:(CGSize)size;
+(UIImage *)imageWithColor:(UIColor *)aColor cornerRadius:(float)cornerRadius;

/**
 *  视图转换为UIImage
 */
+ (UIImage *)imageWithView:(UIView *)view;

+ (UIImage *)image:(UIImage *)image WithTintColor:(UIColor *)tintColor;

//设置图片透明度
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;
/**
 *  等比例缩放
 *
 *  @param size 大小
 *
 *  @return image
 */
-(UIImage*)scaleToSize:(CGSize)size;
/**
 *	按照尺寸缩放图片
 */
- (UIImage *)shrinkImageForSize:(CGSize)aSize;
/**
 *	功能:存储图片到doc目录
 *
 *	@param imageName :图片名称
 *	@param aQuality  :压缩比率
 */
- (NSString *)saveImageWithName:(NSString *)imageName forCompressionQuality:(CGFloat )aQuality;

/*生成不被渲染的图片*/
+ (UIImage *)imageOriginalWithName:(NSString *)imageName;

// 返回一张抗锯齿图片
// 本质：在图片生成一个透明为1的像素边框
- (UIImage *)imageAntialias;

@end


