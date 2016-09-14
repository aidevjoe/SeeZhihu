//
//  QCRefreshView.m
//  SeeZhiHu
//
//  Created by Joe on 16/7/27.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCRefreshView.h"
#import "QCUtilsMacro.h"
@interface QCRefreshView ()
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation QCRefreshView

+ (instancetype)refreshView{
    return [[self alloc] initWithActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
}

- (instancetype)initWithActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)style{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)]) {
        self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        self.activityIndicatorView.centerX = self.width * .5;
        [self.activityIndicatorView setActivityIndicatorViewStyle:style];
        self.activityIndicatorView.hidden = NO;
        [self.activityIndicatorView startAnimating];
        [self addSubview:self.activityIndicatorView];
    }
    return self;
}

+ (instancetype)refreshViewWithActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)style{
    return [[self alloc] initWithActivityIndicatorViewStyle:style];
}

- (void)beginRefresh{
    [self.activityIndicatorView startAnimating];
}

- (void)endRefresh{
    [self.activityIndicatorView stopAnimating];
}
@end
