//
//  QCMessageAlertView.h
//  QCAlertView
//
//  Created by Joe on 16/8/17.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCAlertView.h"

@interface QCMessageAlertView : QCAlertView

/**
 *  将 AlertView 显示在指定的 视图 上
 *
 *  @param contentView 视图
 *  @param message     消息
 *
 *  @return QCMessageAlertView
 */
+ (instancetype)showAlertWithContentView:(UIView *)contentView andMessage:(NSString *)message;

/**
 *  显示 AlertView
 *
 *  @param message 消息
 *
 *  @return QCMessageAlertView
 */
+ (instancetype)showAlertWithMessage:(NSString *)message;

/**
 *  显示 AlertView
 *
 *  @param alertViewDidDismiss 隐藏回调
 *
 *  @return QCMessageAlertView
 */
+ (instancetype)showAlertWithMessage:(NSString *)message Complete:(alertViewDidDismiss)alertViewDidDismiss;

@end
