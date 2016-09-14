//
//  UIImage+extension.m
//  SeeZhihu
//
//  Created by Joe on 16/8/8.
//  Copyright © 2016年 Joe-c. All rights reserved.
//

#import "UIImage+extension.h"

@implementation UIImage (extension)

- (instancetype)imageWithSize:(CGSize)size radius:(CGFloat)radius backgroundColor:(UIColor *)backgroundColor{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    
    backgroundColor = backgroundColor ? backgroundColor : [UIColor whiteColor];
    [backgroundColor setFill];
    UIRectFill(rect);
    
    

    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    [bezierPath addClip];
    
    if (radius != 0) {
        [[UIColor grayColor] setStroke];
        [bezierPath stroke];
    }

    [self drawInRect:rect];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}
@end
