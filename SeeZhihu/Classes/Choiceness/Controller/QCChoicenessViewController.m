//
//  QCChoicenessViewController.m
//  SeeZhiHu
//
//  Created by Joe on 16/7/22.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCChoicenessViewController.h"
#import "QCUtilsMacro.h"
#import "QCNetworking.h"
#import <YYModel.h>
#import "QCPosts.h"
#import "QCPostsCell.h"
#import "QCQuestionViewController.h"
#import "QCRefreshView.h"

@interface QCChoicenessViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *postList;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation QCChoicenessViewController

#pragma mark - lazy loading..

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.y += 10;
        _tableView.height -= 10;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 280.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [QCRefreshView refreshView];
        _tableView.tableFooterView.hidden = YES;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (void)setPostList:(NSMutableArray *)postList{
    if (!_postList) {
        _postList = [NSMutableArray array];
    }
    if (![_postList containsObject:postList]) {
        [_postList addObjectsFromArray:postList];
    }

    [self.tableView reloadData];
}

#pragma mark - life cycle ...

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableView];
    
    self.navigationItem.titleView = [QCRefreshView refreshViewWithActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    
    // 获取文章列表
    [self getPosts];
}

- (void)getPosts{

    NSString *url = self.postList.count ? [NSString stringWithFormat:@"%@/%li", getposts, [[self.postList lastObject] publishtime]] : getposts;
    [QCNetworking getRequestWithUrl:url params:nil cache:YES reload:NO successBlock:^(id returnData, int code, NSString *msg) {
        self.tableView.tableFooterView.hidden = YES;
        self.navigationItem.titleView = nil;
        
        NSMutableArray *postArr = [NSMutableArray array];
        for (NSDictionary *post in returnData[@"posts"]) {
            [postArr addObject:[QCPosts yy_modelWithJSON:post]];
        }
        
        self.postList = postArr;
    } failureBlock:^(NSError *error) {
        self.tableView.tableFooterView.hidden = YES;
        self.navigationItem.titleView = nil;
        
        NSLog(@"%@", error);
    } showHUD:NO];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.postList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [QCPostsCell cellWithTableView:tableView post:self.postList[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QCQuestionViewController *postsVc = [QCQuestionViewController new];
    postsVc.post = self.postList[indexPath.row];
    postsVc.title = [self.postList[indexPath.row] postName];
    [self.navigationController pushViewController:postsVc animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    // 如果tableView还没有数据，就直接返回
    if (self.postList.count == indexPath.row + 1) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多数据
        [self getPosts];
    }
}
@end
