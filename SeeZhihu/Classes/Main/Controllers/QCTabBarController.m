//
//  QCTabBarController.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/13.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCTabBarController.h"
#import "QCNavigationController.h"
#import "QCChoicenessViewController.h"
#import "QCLargeVViewController.h"
#import "QCUtilsMacro.h"
#import "QCProfileViewController.h"

@implementation QCTabBarController

+ (void)initialize{
    UITabBar *tabBar = [UITabBar appearance];
    [tabBar setTintColor:KeyColor];
}

- (void)viewDidLoad{
    [super viewDidLoad];
 
    [self addChildViewController:[QCChoicenessViewController new] imageName:@"toolbar_choiceness" title:@"精选"];
    [self addChildViewController:[QCLargeVViewController new] imageName:@"toolbar_LargeV" title:@"大V"];
    [self addChildViewController:[QCProfileViewController new] imageName:@"profile" title:@"我"];
}


- (void)addChildViewController:(UIViewController *)childController imageName:(NSString *)imageName title:(NSString *)title{
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.title = title;
    childController.title = title;
    QCNavigationController *nav = [[QCNavigationController alloc]initWithRootViewController:childController];
    [self addChildViewController:nav];
}

@end
