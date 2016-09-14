//
//  QCButtonsAlertView.h
//  QCAlertView
//
//  Created by Joe on 16/8/17.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCAlertView.h"

@interface QCButtonsAlertView : QCAlertView

/**
 *  显示 ButtonsAlertView
 *
 *  @param message 消息
 *
 *  @return QCButtonsAlertView
 */
+ (instancetype)showAlertWithMessage:(NSString *)message;

/**
 *  将 ButtonsAlertView 显示在指定的 视图 上
 *
 *  @param contentView 视图
 *  @param message     消息
 *
 *  @return QCButtonsAlertView
 */
+ (instancetype)showAlertWithContentView:(UIView *)contentView andMessage:(NSString *)message;

/**
 *  将 ButtonsAlertView 显示在指定的 视图 上
 *
 *  @param contentView 视图
 *  @param message     消息
 *  @param buttonsTitle 按钮标题数组 最多放两个
 *
 *  @return QCButtonsAlertView
 */
+ (instancetype)showAlertWithContentView:(UIView *)contentView andMessage:(NSString *)message andButtonsTitle:(NSArray *)buttonsTitle;

/**
 *  将 ButtonsAlertView 显示在指定的 视图 上
 *
 *  @param contentView 视图
 *  @param message     消息
 *  @param buttonsTitle 按钮标题数组 最多放两个
 *  @param alertViewblock 点击回调, 返回点击的角标(0~1)
 *
 *  @return QCButtonsAlertView
 */
+ (instancetype)showAlertWithContentView:(UIView *)contentView andMessage:(NSString *)message andButtonsTitle:(NSArray *)buttonsTitle alertViewblock:(alertViewClickOption)alertViewblock;

@end
