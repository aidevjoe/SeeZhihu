//
//  QCRefreshView.h
//  SeeZhiHu
//
//  Created by Joe on 16/7/27.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QCRefreshView : UIView

+ (instancetype)refreshView;

+ (instancetype)refreshViewWithActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)style;

- (void)beginRefresh;

- (void)endRefresh;

@end
