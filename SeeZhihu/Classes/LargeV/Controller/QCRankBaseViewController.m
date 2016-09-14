//
//  QCRankBaseViewController.m
//  SeeZhiHu
//
//  Created by Joe on 16/7/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCRankBaseViewController.h"
#import "QCRank.h"
#import <YYModel.h>
#import "QCUtilsMacro.h"
#import "QCRankCell.h"
#import "QCUserInfoViewController.h"

@interface QCRankBaseViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation QCRankBaseViewController

#pragma mark - lazy loading...

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.height -= 104;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 80;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollsToTop = YES;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (void)setRankData:(NSArray *)rankData{
    if (!_rankData) {
        _rankData = [NSArray array];
    }
    _rankData = rankData;
    [self.tableView reloadData];
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rankData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [QCRankCell cellWithTableView:tableView QCRank:self.rankData[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QCUserInfoViewController *userInfoVc = [QCUserInfoViewController new];
    userInfoVc.userHashValue = [self.rankData[indexPath.row] hashValue];
    userInfoVc.title = [self.rankData[indexPath.row] name];
    [self.navigationController pushViewController:userInfoVc animated:YES];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat viewHeight = scrollView.bounds.size.height + scrollView.contentInset.top;
//    for (QCRankCell *cell in [self.tableView visibleCells]) {
//        CGFloat y = cell.centerY - scrollView.contentOffset.y;
//        CGFloat p = y - viewHeight / 2;
//        CGFloat scale = cos(p / viewHeight * 0.9) * 0.95;
//        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
//            cell.contentView.transform = CGAffineTransformMakeScale(scale, scale);
//        } completion:NULL];
//    }
//}
@end
