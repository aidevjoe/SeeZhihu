//
//  QCTools.h
//  QCMiaoBo
//
//  Created by Joe on 16/7/18.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QCTools : NSObject


/**
 @name 获取本应用的document文件夹地址
 @return 本应用的document文件夹地址
 */
+ (NSString *)documentDirectory;

/*
 判断该知否存在或者为NULL
 */
+(BOOL)isRealKey:(id)value;

/*
 十六进制颜色值转换成UIColor
 */
+ (UIColor *) colorWithHexString: (NSString *)color;

/*
 十六进制颜色值转换成UIColor 包括alpha
 */
+ (UIColor *) colorWithHexString: (NSString *)color alpha:(CGFloat)alpha;

/** 根据颜色返回图片 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**< 返回当前设备型号 */
+ (NSString*)deviceVersion;

@end
