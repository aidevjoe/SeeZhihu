//
//  QCLoadingView.m
//  QCAlertView
//
//  Created by Joe on 16/8/17.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCLoadingView.h"

@interface QCLoadingView ()

@property (nonatomic, strong)  UIView  *blackView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UIView *loadingContentView;
@end

@implementation QCLoadingView

+ (instancetype)shareInstance{
    static QCLoadingView *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[QCLoadingView alloc] init];
    });
    return shareInstance;
}

+ (instancetype)showLoadingView{
    return [self showLoadingViewWithContentView:[[[UIApplication sharedApplication] delegate] window]];
}

+ (instancetype)showLoadingViewWithContentView:(UIView *)contentView{
    QCLoadingView *loadingView = [QCLoadingView shareInstance];
    loadingView.contentView = contentView;
    [loadingView show];
    return loadingView;
}

+ (void)hideLoadingView{
    return [[self shareInstance] hide];
}

- (void)setContentView:(UIView *)contentView {
    self.frame = contentView.bounds;
    [super setContentView:contentView];
}


- (void)show {
    
    if (self.contentView) {
        [self.contentView addSubview:self];
        
        [self createBlackView];
        [self createMessageView];
    }
}

- (void)hide {

    if (self.contentView) {
        [self removeViews];
    }
}

- (void)createBlackView {
    
    self.blackView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.blackView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0];
    [self addSubview:self.blackView];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.blackView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.25];
    }];
}

- (void)createMessageView {
    
    self.loadingContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.loadingContentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    self.loadingContentView.center = CGPointMake(CGRectGetWidth(self.contentView.bounds) / 2.f, CGRectGetHeight(self.contentView.bounds) / 2.f);
    self.loadingContentView.layer.cornerRadius = 5;
    self.loadingContentView.layer.masksToBounds = YES;
    self.loadingContentView.alpha = 0;
    [self.blackView addSubview:self.loadingContentView];
    
    self.activityIndicatorView = [UIActivityIndicatorView new];
    self.activityIndicatorView.center = CGPointMake(CGRectGetWidth(self.loadingContentView.bounds) / 2.f, CGRectGetHeight(self.loadingContentView.bounds) / 2.f);
    [self.activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.loadingContentView addSubview:self.activityIndicatorView];
    
    [self.activityIndicatorView startAnimating];
    
    // 执行动画
    // 执行动画
    [UIView animateWithDuration:.3f animations:^{
        self.loadingContentView.alpha = 1.f;
    }];
}

- (void)removeViews {
    
    [UIView animateWithDuration:0.2f animations:^{
        self.blackView.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}


@end
