//
//  UIView+Extend.m
//
//  Created by Joe-c on 15/6/5.
//  Copyright (c) 2015年 Joe-c. All rights reserved.
//

#import "UIView+Extend.h"

@implementation UIView (Extend)

- (void)setX:(CGFloat)x{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}

- (void)setTagName:(NSString*)name
{
    self.tag = [name hash];
}

- (UIView *)viewWithName:(NSString *)name
{
    return [self viewWithTag:[name hash]];
}

- (void)setPosition:(CGRect)position
{
    self.bounds = CGRectMake(0, 0, position.size.width, position.size.height);
    self.center = CGPointMake(position.origin.x,position.origin.y);
}

- (void)applyRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
}

-(UIView*)findSuperViewWithClass:(Class)superViewClass
{
    UIView *superView = self.superview;
    UIView *foundSuperView = nil;
    
    while (nil != superView && nil == foundSuperView)
    {
        if ([superView isKindOfClass:superViewClass])
        {
            foundSuperView = superView;
        }
        else
        {
            superView  = superView.superview;
        }
    }
    return foundSuperView;
}
@end
