//
//  QCLoadingView.h
//  QCAlertView
//
//  Created by Joe on 16/8/17.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCAlertView.h"

@interface QCLoadingView : QCAlertView

/**
 *  显示 LoadingView
 *
 *  @return QCLoadingView
 */
+ (instancetype)showLoadingView;

/**
 *  显示 LoadingView
 *
 *  @param contentView 容器视图
 *
 *  @return QCLoadingView
 */
+ (instancetype)showLoadingViewWithContentView:(UIView *)contentView;

/**
 *  隐藏 LoadingView
 */
+ (void)hideLoadingView;
@end
