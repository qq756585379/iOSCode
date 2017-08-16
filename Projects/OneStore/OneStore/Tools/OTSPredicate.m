//
//  OTSPredicate.m
//  OneStore
//
//  Created by Yim Daniel on 13-1-16.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import "OTSPredicate.h"
#import <sqlite3.h>

#define PRED_CONDITION_MOBILE       @"^1[0-9]{10}$"
#define PRED_CONDITION_ZUOJIHAO     @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$"//座机号码判断
#define PRED_CONDITION_NUMERIC      @"[0-9]+"
#define PRED_CONDITION_CHARACTER    @"[A-Z0-9a-z]+"
#define PRED_CONDITION_PASSWORD     @"[^\\n\\s]{6,200}"
#define PRED_CONDITION_SPECIAL_CHAR @"[A-Z0-9a-z._%+-@]+"
#define PRED_CONDITION_EMAIL        @"^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$"
#define PRED_CONDITION_BABYNAME     @"^[\u4e00-\u9fa5_a-zA-Z0-9]+$"
#define PRED_CONDITION_ADDRESS_SPECIAL_CHAR     @"[\"\'<>/&*^%$@!?\\\\]"
#define PRED_CONDITION_CHINESE     @"[\u4e00-\u9fa5]"

static NSString *const kPRED_CONDITION_ZUOJIHAO = @"0[0-9]{2,3}-[0-9]{7,8}";//座机号码判断(新添加)

@implementation OTSPredicate

+(BOOL)checkUserName:(NSString *)aCandidate{
    return [self checkPhoneNumber:aCandidate] || [self checkEmail:aCandidate];
}

+(BOOL)checkBindPhoneNumber:(NSString *)aCandidate{
    return [self __checkCandidate:aCandidate condition:PRED_CONDITION_MOBILE];
}

+(BOOL)checkPhoneNumber:(NSString *)aCandidate{
    if (aCandidate.length != 11) {
        return NO;
    }
    return [self __checkCandidate:aCandidate condition:PRED_CONDITION_MOBILE];
}

+(BOOL)checkZuoJiHaoNumber:(NSString *)aCandidate{
    return [self __checkCandidate:aCandidate condition:kPRED_CONDITION_ZUOJIHAO];
}

+(BOOL)checkNumeric:(NSString *)aCandidate
{
    return [self __checkCandidate:aCandidate condition:PRED_CONDITION_NUMERIC];
}

+(BOOL)checkCharacter:(NSString *)aCandidate
{
    return [self __checkCandidate:aCandidate condition:PRED_CONDITION_CHARACTER];
}

+(BOOL)checkPassword:(NSString *)aCandidate
{
    return [self __checkCandidate:aCandidate condition:PRED_CONDITION_PASSWORD];
}

+(BOOL)checkSpecialChar:(NSString *)aCandidate
{
    return [self __checkCandidate:aCandidate condition:PRED_CONDITION_SPECIAL_CHAR];
}

+ (BOOL)checkAddressSpecialChar:(NSString *)aCandidate{
    NSRange urgentRange = [aCandidate rangeOfString:PRED_CONDITION_ADDRESS_SPECIAL_CHAR options:NSRegularExpressionSearch];
    if (urgentRange.location == NSNotFound){
        return NO;
    }
    return YES;
}

+ (BOOL)checkChineseChar:(NSString *)aCandidate{
    NSRange urgentRange = [aCandidate rangeOfString:PRED_CONDITION_CHINESE options:NSRegularExpressionSearch];
    if (urgentRange.location == NSNotFound){
        return NO;
    }
    return YES;
}

+(BOOL)checkEmail:(NSString *)aCandidate{
    return [self __checkCandidate:aCandidate condition:PRED_CONDITION_EMAIL];
}

+ (BOOL)__checkCandidate: (NSString *) aCandidate condition: (NSString*) aCondition{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", aCondition];
    return [predicate evaluateWithObject:aCandidate];
}

+(BOOL)checkBabyName:(NSString *)aCandidate{
    return [self __checkCandidate:aCandidate condition:PRED_CONDITION_BABYNAME];
}

+(BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    return isEomji;
}

#pragma mark - 验证手机号码的方法
+ (BOOL)validateMobile:(NSString *)mobileNum{
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PRED_CONDITION_MOBILE];
    return [regextestmobile evaluateWithObject:mobileNum];
}

+ (BOOL)checkLandlineNumber:(NSString *)aCandidate{
    if ([self __checkCandidate:aCandidate condition:kPRED_CONDITION_ZUOJIHAO]) {
        return [self __checkCandidate:aCandidate condition:kPRED_CONDITION_ZUOJIHAO];
    }
    return [self __checkCandidate:aCandidate condition:PRED_CONDITION_ZUOJIHAO];
}

// 查询手机号 所属地
+ (NSString *)checkPhoneNumberAddress:(NSString *)phoneStr{
    if(phoneStr.length==11){
        return [self selectInfoByPhone:[phoneStr substringToIndex:7] WithMobile:[phoneStr substringToIndex:3]];
    }else{
        return nil;
    }
}

+(NSString *)selectInfoByPhone:(NSString *)phonenumber WithMobile:(NSString *)phonemobile{
    NSMutableString *phoneAddressStr = [[NSMutableString alloc]initWithString:@""];
    NSString *SelectWhatMobile = @"SELECT mobile FROM numbermobile where uid=";
    NSString *SelectWhatMobileFull = [SelectWhatMobile stringByAppendingFormat:@"%@", phonemobile];
    sqlite3 *database;
    if (sqlite3_open([[self findDatabase] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [SelectWhatMobileFull UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            int mobilenumber = sqlite3_column_int(stmt, 0);
            if (mobilenumber) {
                NSString *mobileNumberString = [NSString stringWithFormat:@"%d",mobilenumber];
                NSString *SelectWhatMobileName = @"SELECT mobile FROM mobilenumber WHERE uid=";
                NSString *SelectWhatMobileNameFull = [SelectWhatMobileName stringByAppendingFormat:@"%@", mobileNumberString];
                sqlite3_stmt *stmt2;
                if (sqlite3_prepare_v2(database, [SelectWhatMobileNameFull UTF8String], -1, &stmt2, nil) == SQLITE_OK) {
                    while (sqlite3_step(stmt2) == SQLITE_ROW) {
                        char *mobilename = (char *)sqlite3_column_text(stmt2, 0);
                        NSString *mobilenamestring = [[NSString alloc] initWithUTF8String:mobilename];
                        if (mobilenamestring!= NULL) {
                            //mylabelmobile.text = mobilenamestring;//中国移动
                            [phoneAddressStr appendString:[mobilenamestring substringFromIndex:2]];
                        }
                    }
                }
                sqlite3_finalize(stmt2);
            }
        }
        sqlite3_finalize(stmt);
    }
    sqlite3_stmt *stmt3;
    NSString *SelectCityNumberByPhoneNumber = @"SELECT city FROM phonenumberwithcity WHERE uid=";
    NSString *SelectCityNumberByPhoneNumberFull = [SelectCityNumberByPhoneNumber stringByAppendingFormat:@"%@", phonenumber];
    if (sqlite3_prepare_v2(database, [SelectCityNumberByPhoneNumberFull UTF8String], -1, &stmt3, nil) == SQLITE_OK) {
        if (sqlite3_step(stmt3) == SQLITE_ROW) {
            int citynumber = sqlite3_column_int(stmt3, 0);
            NSString *citynumberNSString = [NSString stringWithFormat:@"%d",citynumber];
            if (citynumberNSString != nil) {
                NSString *SelectCityNameAndCtiyZoneByCityBumber = @"SELECT city,zone FROM citywithnumber WHERE uid=";
                NSString *SelectCityNameAndCtiyZoneByCityBumberFull = [SelectCityNameAndCtiyZoneByCityBumber stringByAppendingFormat:@"%@", citynumberNSString];
                sqlite3_stmt *stmt4;
                if (sqlite3_prepare_v2(database, [SelectCityNameAndCtiyZoneByCityBumberFull UTF8String], -1, &stmt4, nil) == SQLITE_OK) {
                    if (sqlite3_step(stmt4) == SQLITE_ROW) {
                        char *cityname = (char *)sqlite3_column_text(stmt4, 0);
                        int cityzonecode = sqlite3_column_int(stmt4, 1);
                        NSString *cityNameNSString = [[NSString alloc] initWithUTF8String:cityname];
                        NSString *cityzonecodeNnumber = [@"0" stringByAppendingFormat:@"%d",cityzonecode];
                        if (cityNameNSString != nil && cityzonecodeNnumber != nil) {
                            //mylabellocation.text = cityNameNSString;//上海
                            //mylabelzonecode.text = cityzonecodeNnumber;
                            [phoneAddressStr insertString:cityNameNSString atIndex:0];
                        }
                    }
                    sqlite3_finalize(stmt4);
                }
            }
        }
        sqlite3_finalize(stmt3);
    }
    sqlite3_close(database);
    return phoneAddressStr;
}

+(NSString *)findDatabase{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"location_Numbercity_citynumber" ofType:@"db"];
    return path;
}

@end
