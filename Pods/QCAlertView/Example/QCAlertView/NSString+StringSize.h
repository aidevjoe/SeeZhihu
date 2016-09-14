//
//  NSString+StringSize.h
//  QCAlertView
//
//  Created by Joe on 16/8/18.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (StringSize)

/**
 *  获取字符串的高度与固定宽度。
 *
 *  @param attribute 字符串的属性, 例如. attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]}
 *  @param width     固定宽度.
 *
 *  @return 字符串高度
 */
- (CGSize)sizeWithAttribute:(NSDictionary <NSString *, id> *)attribute width:(CGFloat)width;

@end
