//
//  UIView+Extend.h
//
//  Created by Joe-c on 15/6/5.
//  Copyright (c) 2015年 Joe-c. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extend)

@property (nonatomic ,assign)CGFloat x;
@property (nonatomic ,assign)CGFloat y;
@property (nonatomic ,assign)CGFloat width;
@property (nonatomic ,assign)CGFloat height;
@property (nonatomic ,assign)CGSize size;
@property (nonatomic ,assign)CGPoint origin;
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;
@property(nonatomic,assign,readonly)CGFloat maxX;
@property(nonatomic,assign,readonly)CGFloat maxY;

/** 通过字符串的hash值设置tag */
- (void)setTagName:(NSString*)name;

/** 通过字符串的hash值去找View */
- (UIView *)viewWithName:(NSString *)name;

- (void)setPosition:(CGRect)position;
//给任何View加上圆角
- (void)applyRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius;

/**
 *  查找view的父类控件
 *
 *  @param superViewClass 父类
 *
 *  @return 父类视图控件
 */
-(UIView*)findSuperViewWithClass:(Class)superViewClass;

@end
