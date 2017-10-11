//
//  LogDefine.h
//  Common
//
//  Created by 杨俊 on 2017/10/11.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#ifdef DEBUG
#define DLog(fmt, ...) \
{ \
NSLog(@"MARK:=====================================\n"); \
NSLog(@"%@ [Line %d] %s \n",[self class],__LINE__,__PRETTY_FUNCTION__); \
NSLog((fmt), ##__VA_ARGS__); \
NSLog(@"MARK END:=================================\n"); \
}
#else
#define DLog(...)
#endif

#define PrintSize(o) DLog(@"CGSize: {%.0f, %.0f}", (o).width, (o).height)
#define PrintRect(o) DLog(@"NSRect: {{%.0f, %.0f}, {%.0f, %.0f}}", (o).origin.x, (o).origin.x, (o).size.width, (o).size.height)
