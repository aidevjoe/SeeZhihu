//
//  QCWebViewController.h
//  QCMiaoBo
//
//  Created by Joe on 16/7/19.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCViewController.h"

@interface QCWebViewController : QCViewController

+ (QCWebViewController *)webViewWithUrl:(NSString *)url title:(NSString *)title;
+ (QCWebViewController *)webViewWithUrl:(NSString *)url;

- (instancetype)initWithUrl:(NSString *)url title:(NSString *)title;
@end
