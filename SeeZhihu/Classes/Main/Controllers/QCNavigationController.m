//
//  QCNavigationController.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/13.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCNavigationController.h"
#import "QCUtilsMacro.h"

@implementation QCNavigationController


+ (void)initialize{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarTintColor:KeyColor];
    [bar setTintColor:[UIColor whiteColor]];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0){
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    
    // 判断两种情况: push 和 present
    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
        [self popViewControllerAnimated:YES];
}

@end
