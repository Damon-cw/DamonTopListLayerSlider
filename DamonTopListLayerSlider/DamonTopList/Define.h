//
//  Define.h
//  DamonTopList
//
//  Created by Damon on 16/4/7.
//  Copyright © 2016年 Damon. All rights reserved.
//

#ifndef Define_h
#define Define_h


#endif /* Define_h */


#ifdef __OBJC__
#import "UIView+Frame.h"



#endif

// 分割线
#define DT_SEPARETE_LINE_WIDTH (1.0 / [UIScreen mainScreen].scale)

#define DTMAINCOLOR   RGBFromColor(0x23A3C3)
#define DTSepareteLineDarkColor  RGBFromColor(0xa9a9a9)
#define DTSepareteLineNomalColor RGBFromColor(0xdddddd)




// 屏幕的宽
#define SCREENWIDTH   [UIScreen mainScreen].bounds.size.width
// 屏幕的高
#define  SCREENHEIGHT [UIScreen mainScreen].bounds.size.height



//16进制颜色值
#define RGBFromColor(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//16进制颜色值
#define RGBFromAlphaColor(rgbValue, a) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#ifdef DEBUG
#define DTLog(...) NSLog(__VA_ARGS__)
#else
#define DTLog(...)
#endif
/*
 
 作者: 崔嵬
 Q Q: 525643907
 邮箱: cuiwei_0408@163.com
 注: 欢迎互相学习与交流.
 
 */