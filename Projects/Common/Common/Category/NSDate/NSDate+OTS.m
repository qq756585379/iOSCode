//
//  NSDate+OTS.m
//  OneStore
//
//  Created by huang jiming on 13-6-18.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import "NSDate+OTS.h"
#import "NSString+safe.h"
#import "OTSGlobalValue.h"

@implementation NSDate(OTS)

- (NSInteger )distanceNowDays
{
	NSTimeInterval seconds = [self timeIntervalSinceNow];
	if (seconds < 0) {
		seconds = -seconds;
	}
	NSInteger daySeconds = 60 * 60 * 24;
	NSInteger days = (NSInteger)(seconds / daySeconds);
	return days;
}

- (NSString *)distanceNowDescribe
{
	NSTimeInterval sinceTime = [self timeIntervalSinceNow];
	NSInteger dayOfSeconds = 60 * 60 * 24;
	NSInteger days = (NSInteger)(sinceTime / dayOfSeconds);
	if (days < 0) {
		days = 0;
	}
	NSInteger hourOfSeconds = 60 * 60;
	NSInteger hours = ((NSInteger)sinceTime / hourOfSeconds) % 24;

	NSInteger minuteOfSeconds = 60;
	NSInteger minutes = ((NSInteger)sinceTime / minuteOfSeconds) % 60;
	NSInteger seconds = (NSInteger)sinceTime % 60;

	NSString *describe = nil;
	if (days > 1) {
		describe = [NSString stringWithFormat:@"%d天",(int)days];
	}
	else if (hours > 1) {
		describe = [NSString stringWithFormat:@"%d小时",(int)hours];
	}
    else if(minutes > 1) {
		describe = [NSString stringWithFormat:@"%d分",(int)minutes];
	}
    else {
		describe = [NSString stringWithFormat:@"%d秒",(int)seconds];
	}


	return describe;
}

- (NSDictionary *)distanceNowDic
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:kCFCalendarUnitDay|kCFCalendarUnitHour| kCFCalendarUnitMinute|kCFCalendarUnitSecond fromDate:[NSDate date] toDate:self options:0];
    
    NSDictionary * dic = nil;
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@(comps.day),@"day",@(comps.hour),@"hour",@(comps.minute),@"minute",@(comps.second),@"second",nil];
    
	return dic;
}

- (NSDictionary *)distanceYearMonthDayFromNowDic
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:kCFCalendarUnitYear|kCFCalendarUnitMonth| kCFCalendarUnitDay fromDate:self toDate:[NSDate date] options:0];
    
    NSDictionary * dic = nil;
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@(comps.year),@"year",@(comps.month),@"month",@(comps.day),@"day",nil];
    
	return dic;
}

/**
 *  功能:转换成日期字符串，精确到天
 */
- (NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.timeZone = [NSTimeZone localTimeZone];
    
    NSString *ret = [formatter stringFromDate:self];
    
    if (ret.length >= 10) {
        ret = [ret safeSubstringWithRange:NSMakeRange(0, 10)];
    }
    return ret;
}

/**
 *  功能:转换成时间字符串，精确到秒
 */
- (NSString *)timeString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.timeZone = [NSTimeZone localTimeZone];
    
    NSString *ret = [formatter stringFromDate:self];
    
    if (ret.length >= 19) {
        ret = [ret safeSubstringWithRange:NSMakeRange(0, 19)];
    }
    return ret;
}

/**
 *  功能:转换成时间字符串，精确到秒
 */
- (NSString *)anotherTimeString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy.MM.dd HH:mm:ss";
    formatter.timeZone = [NSTimeZone localTimeZone];
    
    NSString *ret = [formatter stringFromDate:self];
    
    if (ret.length >= 19) {
        ret = [ret safeSubstringWithRange:NSMakeRange(0, 19)];
    }
    return ret;
}

/**
 *  功能:转换成时间字符串，精确到分
 */
- (NSString *)timeStringToSecond
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.timeZone = [NSTimeZone localTimeZone];
    
    NSString *ret = [formatter stringFromDate:self];
    
    if (ret.length >= 19) {
        ret = [ret safeSubstringWithRange:NSMakeRange(0, 16)];
    }
    return ret;
}

/**
 *  功能:转换成时间字符串，精确到分
 */
- (NSString *)anotherTimeStringToSecond
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy.MM.dd HH:mm:ss";
    formatter.timeZone = [NSTimeZone localTimeZone];
    
    NSString *ret = [formatter stringFromDate:self];
    
    if (ret.length >= 19) {
        ret = [ret safeSubstringWithRange:NSMakeRange(0, 16)];
    }
    return ret;
}

/**
 *  功能:转换成时间字符串，获取时分秒部分
 */
- (NSString *)hourMinuteSecondString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.timeZone = [NSTimeZone localTimeZone];
    
    NSString *ret = [formatter stringFromDate:self];
    
    if (ret.length >= 19) {
        ret = [ret safeSubstringWithRange:NSMakeRange(11, 8)];
    }
    return ret;
}

/**
 *  功能:转换成时间字符串，获取时分部分
 */
- (NSString *)hourMinuteString
{

	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
	formatter.timeZone = [NSTimeZone localTimeZone];

	NSString *ret = [formatter stringFromDate:self];

	if (ret.length >= 19) {
		ret = [ret safeSubstringWithRange:NSMakeRange(11, 5)];
	}
	return ret;
}

/**
 *  功能:转换成时间字符串，获取时部分
 */
- (NSString *)hourString
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.timeZone = [NSTimeZone localTimeZone];
    
    NSString *ret = [formatter stringFromDate:self];
    
    if (ret.length >= 19) {
        ret = [ret safeSubstringWithRange:NSMakeRange(11, 2)];
    }
    return ret;
}

/**
 *  功能:转换成时间字符串，获取月天时分秒部分
 */
- (NSDictionary *)monthDayHourMinuteString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.timeZone = [NSTimeZone localTimeZone];
    
    NSString *ret = [formatter stringFromDate:self];
    NSDictionary * dic = nil;
    if (ret.length >= 19) {
        NSString *month = [ret safeSubstringWithRange:NSMakeRange(5, 2)];
        NSString *day = [ret safeSubstringWithRange:NSMakeRange(8, 2)];
        NSString *hour = [ret safeSubstringWithRange:NSMakeRange(11, 2)];
        NSString *minute = [ret safeSubstringWithRange:NSMakeRange(14, 2)];
        dic = [NSDictionary dictionaryWithObjectsAndKeys:month,@"month",day,@"day",hour,@"hour",minute,@"minute", nil];
    }
    return dic;
}

/**
 功能:转换成周
 */
- (NSString *)zhouString {
    
    NSString *g_strZhou[] = {
        @"周日",
        @"周一",
        @"周二",
        @"周三",
        @"周四",
        @"周五",
        @"周六"
    };

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:kCFCalendarUnitWeekday|NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    if ( comps.weekday > 0 && comps.weekday <= 7) {
        return g_strZhou[comps.weekday-1];
    }else {
        return @"";
    }
}

/**
 *  是否是今天的日期
 *
 *  @return 返回YES OR NO
 */
- (BOOL)isTodayDate
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *today = [dateFormatter stringFromDate:[NSDate date]];
    NSString *day = [dateFormatter stringFromDate:self];
    
    if ([today isEqualToString:day])
    {
        return YES;
    }
    
    return NO;
}

/**
 *  是否昨天
 */
- (BOOL)isYesterday
{
    NSDate *nowDate = [OTSGlobalValue sharedInstance].serverTime;
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selStr = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:selStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

/**
 *  是否是今年的日期
 *
 *  @return 返回YES OR NO
 */
- (BOOL)isCurrentYearDate
{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *today = [dateFormatter stringFromDate:[NSDate date]];
    NSString *day = [dateFormatter stringFromDate:self];
    
    if ([today isEqualToString:day])
    {
        return YES;
    }
    return NO;
}

/**
 *  判断与当前时间差值
 */
- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}


/**
 *  用逗号分隔的日期字符串
 *
 *  @return 逗号分隔的日期字符串
 */
- (NSString *)dateStringWithDot
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy.MM.dd";
    formatter.timeZone = [NSTimeZone localTimeZone];
    NSString *ret = [formatter stringFromDate:self];
    return ret;
}
@end
