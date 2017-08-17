//
//  NSDate+Format.h
//  MessageCenter
//
//  Created by xiaxiongzhi on 14-9-16.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (Format)

/**
 *  把日期转化为yyyy/MM/dd
 *
 *  @return 转化后的字符串
 */
-(NSString *)dateToString_yyyyMMdd;

/**
 *  把日期转化为yyyy-MM-dd
 *
 *  @return 转化后的字符串
 */
-(NSString *)dateToString_yyyyMMdd1;

/**
 *  把日期转化为yyyy-MM-dd HH:mm
 *
 *  @return 转化后的字符串
 */
-(NSString *)dateToString_yyyyMMddHHmm;

@end
