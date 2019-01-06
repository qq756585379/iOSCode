//
//  ColorDefine.h
//  Common
//
//  Created by yangjun on 2017/5/8.
//  Copyright © 2017年 yangjun. All rights reserved.
//

#define RANDOM_COLOR 	 [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f \
blue:arc4random()%255/255.f alpha:arc4random()%255/255.f]

#define RGB(r,g,b) 		 [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r,g,b,a)	 [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 \
alpha:1.0]

#define HEXRGBACOLOR(rgbValue, alphaValue) [UIColor colorWithRed : ((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green : ((float)((rgbValue & 0x00FF00) >> 8)) / 255.0 blue : ((float)(rgbValue & 0x0000FF)) / 255.0 alpha:alphaValue]

#define HEXRGBCOLOR(rgbValue) [UIColor colorWithRed : ((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green : ((float)((rgbValue & 0x00FF00) >> 8)) / 255.0 blue : ((float)(rgbValue & 0x0000FF)) / 255.0 alpha:1.0f]

//special color
#define OTSORANGECOLOR 			[UIColor colorWithRed:223.0/255 green:119.0/255 blue:28.0/255 alpha:1]
#define OTSTEXTCOLOR   			[UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1]
#define OTSREDCOLOR 			[UIColor colorWithRed:220.0/255 green:0/255 blue:0/255 alpha:1]
#define OTSBLUECOLOR 			[UIColor colorWithRed:104.0/255 green:144.0/255 blue:223.0/255 alpha:1]
#define OTSDISABLECLOLR 		[UIColor colorWithRed:169.0/255 green:169.0/255 blue:169.0/255 alpha:1.0]
#define OTSGREYCLOLR(color) 	[UIColor colorWithRed:color/255.0 green:color/255.0 blue:color/255.0 alpha:1.0]
#define OTSSUBTEXTCOLOR			[UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1]
#define OTSORANGECOLOR			[UIColor colorWithRed:223.0/255 green:119.0/255 blue:28.0/255 alpha:1]
#define OTSBLUECOLOR 			[UIColor colorWithRed:104.0/255 green:144.0/255 blue:223.0/255 alpha:1]
#define OTSDISABLEGRAYCOLOR 	[UIColor colorWithRed:189.0/255 green:189/255 blue:189/255 alpha:1]
#define SHOPPING_ORANGE_COLOR 	[UIColor colorWithRed:246.0/255 green:60/255 blue:45/255 alpha:1]





