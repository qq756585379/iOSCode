//
//  NSString+tripledes.h
//  demo
//
//  Created by pg on 16/6/8.
//  Copyright © 2016年 赵大成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (tripledes)

//加密hciToken数据
+ (NSString*)getHciTokenTripleDESStringWithDictionary:(NSMutableDictionary*)hciTekonDictionary;

@end
