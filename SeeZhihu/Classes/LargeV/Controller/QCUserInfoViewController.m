//
//  QCUserInfoViewController.m
//  SeeZhiHu
//
//  Created by Joe on 16/7/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCUserInfoViewController.h"
#import "QCNetworking.h"
#import "QCUtilsMacro.h"
#import <YYModel.h>
#import "QCUserInfo.h"
#import "QCUserInfoHeaderView.h"
#import "QCAnswerCell.h"
#import "QCWebViewController.h"
#import "QCTopanswers.h"

@interface QCUserInfoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) QCUserInfo *userInfo;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation QCUserInfoViewController

#pragma mark - lazy loading...

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 280.0f;//推测高度，必须有，可以随便写多少
        _tableView.rowHeight = UITableViewAutomaticDimension;//iOS8之后默认就是这个值，可以省略
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - life cycle...

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.966 alpha:1.000];
    
    [QCNetworking getRequestWithUrl:[userdetail2 stringByAppendingString:self.userHashValue] params:nil cache:YES refresh:YES successBlock:^(id returnData, int code, NSString *msg) {
        self.userInfo = [QCUserInfo yy_modelWithDictionary:returnData];
        [self.tableView reloadData];
        self.tableView.tableHeaderView = [QCUserInfoHeaderView headerViewWithUserInfo:self.userInfo];
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
    } showHUD:YES];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userInfo.topanswers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [QCAnswerCell cellWithTableView:tableView topanswers:self.userInfo.topanswers[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QCTopanswers *topanswers = self.userInfo.topanswers[indexPath.row];
    QCWebViewController *webVc = [QCWebViewController webViewWithUrl:topanswers.link title:topanswers.title];
    [self.navigationController pushViewController:webVc animated:YES];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UISegmentedControl *segmented = [[UISegmentedControl alloc] initWithItems:@[@"答案", @"更多"]];
//    segmented.tintColor =  [UIColor grayColor];;
//    segmented.selectedSegmentIndex = 0;
//    segmented.backgroundColor =  [UIColor colorWithWhite:0.966 alpha:1.000];;
//    return segmented;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 30;
//}
@end
