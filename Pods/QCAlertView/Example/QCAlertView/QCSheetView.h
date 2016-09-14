//
//  QCSheetView.h
//  QCAlertView
//
//  Created by Joe-c on 16/8/17.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCAlertView.h"

@interface QCSheetView : QCAlertView

/**
 *  显示 sheetView
 *
 *  @param message        标题消息
 *  @param buttonsTitle   按钮标题数组
 *  @param alertViewblock 点击回调 (1~...)
 *
 *  @return QCSheetView
 */
+ (instancetype)showSheetViewWithMessage:(NSString *)message andButtonsTitle:(NSArray *)buttonsTitle alertViewblock:(alertViewClickOption)alertViewblock;

@end
