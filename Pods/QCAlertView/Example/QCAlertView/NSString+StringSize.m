//
//  NSString+StringSize.m
//  QCAlertView
//
//  Created by Joe on 16/8/18.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "NSString+StringSize.h"

@implementation NSString (StringSize)

- (CGSize)sizeWithAttribute:(NSDictionary <NSString *, id> *)attribute width:(CGFloat)width{
    NSParameterAssert(attribute);
    CGSize size = CGSizeZero;
    if (self.length) {
        CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                           options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil];
        
        size = rect.size;
    }
    return size;
}

@end
