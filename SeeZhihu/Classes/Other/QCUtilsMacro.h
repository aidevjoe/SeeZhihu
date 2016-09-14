//
//  UtilsMacro.h
//  QCMiaoBo
//
//  Created by Joe on 16/7/14.
//  Copyright © 2016年 Joe. All rights reserved.
//
#import "UIView+Extend.h"
#import "QCTools.h"

#ifndef QCUtilsMacro_h
#define QCUtilsMacro_h

#pragma mark - 请求地址
#define BaseAddress @"http://api.kanzhihu.com/"
#define getposts @"http://api.kanzhihu.com/getposts"
#define getpostanswers @"http://api.kanzhihu.com/getpostanswers/"
#define userdetail2 @"http://api.kanzhihu.com/userdetail2/"
#define searchuser @"http://api.kanzhihu.com/searchuser/"

//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\n方法:%s 行:%d 内容:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#define NLLocalizedString(key) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

//屏幕宽高
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define PI 3.141592654

//默认的通知中心
#define DefaultNotificationCenter [NSNotificationCenter defaultCenter]
static NSString * const kStatusBarTappedNotification = @"statusBarTappedNotification";

// 看热门主播
#define kGoToHotLiveNotice @"GoToHotLiveNotice"

//宏定义检测block是否可用
#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };

// 弱引用
#define WeakSelf __weak typeof(self) weakSelf = self;

#pragma mark - 颜色
// 随机颜色
#define RANDOM_COLOR [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]

// 颜色(RGB)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBCOLOR(r, g, b) RGBACOLOR(r, g, b, 1.0)

//颜色(Hex)
#define HexColor(color) [QCTools colorWithHexString:(color)]
#define HexColorAndAlpha(color, alp) [QCTools colorWithHexString:(color) alpha:(alp)]

//友盟 AppKey
#define UmengAppkey @"57b675a2e0f55aa0620015c0"

//全局颜色
#define KeyColor UIColorFromRGB(0x13ABFF)
//背景色
#define gbColor UIColorFromRGB(0xF6F2F4)

#endif /* QCUtilsMacro_h */

