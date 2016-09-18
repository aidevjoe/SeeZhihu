//
//  QCWebViewController.h
//  QCMiaoBo
//
//  Created by Joe on 16/7/19.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCViewController.h"
#import "RxWebViewController.h"

@interface QCWebViewController : RxWebViewController

+ (QCWebViewController *)webViewWithUrl:(NSString *)url title:(NSString *)title;
+ (QCWebViewController *)webViewWithUrl:(NSString *)url;

@end
