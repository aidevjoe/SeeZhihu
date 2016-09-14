//
//  QCSearchViewController.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/20.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCSearchViewController.h"
#import "QCUtilsMacro.h"
#import "QCNetworking.h"
#import <YYModel.h>
#import "QCRank.h"
#import "QCSearchUserCell.h"
#import "QCRankCell.h"
#import "QCUserInfoViewController.h"

@interface QCSearchViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *searchUserList;

@end

@implementation QCSearchViewController

#pragma mark - lazy loading...

- (NSArray *)searchUserList{
    if (!_searchUserList) {
        _searchUserList = [NSArray array];
    }
    return _searchUserList;
}

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

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self tableView];
    
    [self setupNavigationItem];
}

#pragma mark - custom action

- (void)setupNavigationItem{
    self.navigationItem.leftBarButtonItem = ({
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 65, 28)];
        self.searchBar.placeholder = @"搜索用户名";
        self.searchBar.delegate = self;
        [[UIBarButtonItem alloc] initWithCustomView:self.searchBar];
    });
    
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
        [cancelBtn setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
        cancelBtn;
    });
    
    [self.searchBar becomeFirstResponder];
}

- (void)cancelClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [QCNetworking getRequestWithUrl:[searchuser stringByAppendingString:searchBar.text] params:nil cache:YES successBlock:^(id returnData, int code, NSString *msg) {
        NSMutableArray *searchResultArr = [NSMutableArray array];
        for (NSDictionary *user in returnData[@"users"]) {
            [searchResultArr addObject:[QCRank yy_modelWithJSON:user]];
        }
        self.searchUserList = searchResultArr;
        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);

    } showHUD:YES];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchUserList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [QCRankCell cellWithTableView:tableView QCRank:self.searchUserList[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QCUserInfoViewController *userInfoVc = [QCUserInfoViewController new];
    userInfoVc.userHashValue = [self.searchUserList[indexPath.row] hashValue];
    userInfoVc.title = [self.searchUserList[indexPath.row] name];
    [self.navigationController pushViewController:userInfoVc animated:YES];
}
@end
