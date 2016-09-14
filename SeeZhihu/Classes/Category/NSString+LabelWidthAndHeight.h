//
//  NSString+LabelWidthAndHeight.h
//  ZiPeiYi
//
//  Created by YouXianMing on 15/12/9.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (LabelWidthAndHeight)

/**
 *  获取字符串的高度
 *
 *  @param attribute 字符串的属性, 例如. attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]}
 *  @param width     固定宽度.
 *
 *  @return 字符串高度
 */
- (CGFloat)heightWithStringAttribute:(NSDictionary <NSString *, id> *)attribute fixedWidth:(CGFloat)width;

/**
 *  获取字符串的宽度
 *
 *  @param attribute 字符串的属性, 例如. attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]}
 *
 *  @return 字符串宽度
 */
- (CGFloat)widthWithStringAttribute:(NSDictionary <NSString *, id> *)attribute;

/**
 *  获取一行文本高度
 *
 *  @param attribute 字符串的属性, 例如. attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]}
 *
 *  @return 字符串高度
 */
+ (CGFloat)oneLineOfTextHeightWithStringAttribute:(NSDictionary <NSString *, id> *)attribute;

/**
 *  获取字符串的高度与宽度。
 *
 *  @param attribute 字符串的属性, 例如. attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]}
 *  @param width     固定宽度.
 *
 *  @return 字符串高度
 */
- (CGSize)sizeWithAttribute:(NSDictionary <NSString *, id> *)attribute width:(CGFloat)width;

@end
