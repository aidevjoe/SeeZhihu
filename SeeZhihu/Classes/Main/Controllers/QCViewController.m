//
//  QCViewController.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/14.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCViewController.h"
#import "QCUtilsMacro.h"

@implementation QCViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [DefaultNotificationCenter addObserverForName:kStatusBarTappedNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [self statusBarTappedAction];
    }];
}


- (void)statusBarTappedAction{};

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [DefaultNotificationCenter removeObserver:self];
}
@end
