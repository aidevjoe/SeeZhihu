//
//  QCUserInfoHeaderView.h
//  SeeZhiHu
//
//  Created by Joe on 16/7/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QCUserInfo;

@interface QCUserInfoHeaderView : UIView

+ (instancetype)headerViewWithUserInfo:(QCUserInfo *)userInfo;

@property (nonatomic, strong) QCUserInfo *userInfo;

@end
