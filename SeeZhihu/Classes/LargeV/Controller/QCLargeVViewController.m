//
//  QCLargeVViewController.m
//  SeeZhiHu
//
//  Created by Joe on 16/7/22.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCLargeVViewController.h"
#import "QCSliderView.h"
#import "QCUtilsMacro.h"
#import "QCSearchViewController.h"

@interface QCLargeVViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) QCSliderView *sliderView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *childVc;

@end

@implementation QCLargeVViewController

#pragma mark - lazy loading...

- (NSArray *)childVc{
    if (!_childVc) {
        _childVc = @[@"QCVoteViewController", @"QCFollowerViewController"];
    }
    return _childVc;
}

- (QCSliderView *)sliderView{
    if (!_sliderView) {
        _sliderView = [QCSliderView sliderViewWithTitles:@[@"赞同榜", @"粉丝榜"]];
    }
    return _sliderView;
}

#pragma mark - life cycle...

- (void)loadView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    scrollView.contentSize = CGSizeMake(ScreenWidth * self.childVc.count, 0);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.scrollsToTop = NO;
    self.scrollView = scrollView;
    self.view = self.scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化titleView
    [self initNavigation];
    
    //添加子视图
    [self initChildController];
}


#pragma mark - custom action

- (void)initNavigation{
    [self.navigationItem setTitleView:self.sliderView];
    
    WeakSelf;
    self.sliderView.didSelectedTitleBtn = ^(NSInteger index){
        [weakSelf.scrollView setContentOffset:CGPointMake(index * ScreenWidth, -64) animated:YES];
    };
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStyleDone target:self action:@selector(searchClick)];
}

- (void)searchClick{
    [self.navigationController pushViewController:[QCSearchViewController new] animated:YES];
}

- (void)initChildController{
    for (int i = 0; i < self.childVc.count; i ++) {
        UIViewController *vc = [[NSClassFromString(self.childVc[i]) alloc] init];
        vc.view.frame = CGRectMake(ScreenWidth * i, 0, ScreenWidth, ScreenHeight);
        [self.scrollView addSubview:vc.view];
        [self addChildViewController:vc];
    }
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / (ScreenWidth * .7);
    
    [self.sliderView setSelectedBtnWithIndex:index];
}

@end
