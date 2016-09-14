//
//  QCPostsViewController.m
//  SeeZhiHu
//
//  Created by Joe on 16/7/25.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCQuestionViewController.h"
#import "QCNetworking.h"
#import "QCUtilsMacro.h"
#import "QCPosts.h"
#import <YYModel.h>
#import "QCQuestion.h"
#import "QCQuestionCell.h"
#import "UITableView+CellClass.h"
#import "QCCellDataAdapter.h"

@interface QCQuestionViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *questionList;

@end

@implementation QCQuestionViewController

#pragma mark - lazy loading...

- (NSMutableArray *)questionList{
    if (!_questionList) {
        _questionList = [NSMutableArray array];
    }
    return _questionList;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.y += 10;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[QCQuestionCell class] forCellReuseIdentifier:[QCQuestionCell description]];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


#pragma mark - life cycle...

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableView];
    
    [self getPostList];
}

- (void)getPostList{
    
    NSString *dateStr = [self.post.date stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [QCNetworking getRequestWithUrl:[NSString stringWithFormat:@"%@%@/%@", getpostanswers, dateStr, self.post.name] params:nil cache:YES successBlock:^(id returnData, int code, NSString *msg) {
        for (NSDictionary *questionDict in returnData[@"answers"]) {
            QCQuestion *question = [QCQuestion yy_modelWithJSON:questionDict];
            ;
            [self.questionList addObject:[QCQuestionCell dataAdapterWithCellReuseIdentifier:nil data:question cellHeight:[QCQuestionCell cellHeightWithData:question] type:0]];
        }
        
        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
    } showHUD:YES];

}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.questionList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueAndLoadContentReusableCellFromAdapter:self.questionList[indexPath.row] indexPath:indexPath controller:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [(QCCustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.questionList[indexPath.row] cellHeight];
}

@end
