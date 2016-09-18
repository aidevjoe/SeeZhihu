//
//  QCProfileViewController.m
//  SeeZhihu
//
//  Created by Joe on 16/9/18.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCProfileViewController.h"
#import "QCNetworking.h"
#import <SDWebImageManager.h>
#import "QCWebViewController.h"
#import <PureLayout.h>
#import "QCUtilsMacro.h"

@interface QCProfileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) UIView *headerView;

@end

@implementation QCProfileViewController

#pragma mark - lazy loading...

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 300)];
        
        [self.view addSubview:_headerView];
        
        UIImageView *imageV = [UIImageView new];
        imageV.image = [UIImage imageNamed:@"Joe"];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.clipsToBounds = YES;
        [_headerView addSubview:imageV];
        
        [imageV autoPinEdgesToSuperviewEdges];
    }
    return _headerView;
}

- (NSArray *)dataSource{
    if (!_dataSource) {
        
        NSDictionary *sourceCode = @{
                                     @"title" : @"源码",
                                     @"icon" : @"code",
                                     @"detail" : @"Github",
                                     @"link" : @"https://github.com/Joe0708/SeeZhihu"
                                     };
        NSDictionary *author =     @{
                                     @"title" : @"作者",
                                     @"icon" : @"author",
                                     @"detail" : @"Joe",
                                     @"link" : @"https://github.com/Joe0708"
                                     };
        NSDictionary *email =      @{
                                     @"title" : @"邮箱",
                                     @"icon" : @"email",
                                     @"detail" : @"joesir7@Foxmail.com"
                                     };
        
        NSArray *section1 = @[sourceCode, author, email];
        
        NSDictionary *clearCache = @{
                                     @"title" : @"清除缓存",
                                     @"icon" : @"cache",
                                     @"detail" : @"0 M"
                                     };
        
        NSArray *section2 = @[clearCache];
        
        _dataSource = @[section1, section2];
    }
    return _dataSource;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - life cycle...

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = self.headerView;
}


#pragma mark - UITableViewDataSource, UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    NSDictionary *dict = self.dataSource[indexPath.section][indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.detailTextLabel.text = dict[@"detail"];
    cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];

    if (indexPath.section) {
        NSUInteger sdWebImageCacheSize = [SDWebImageManager sharedManager].imageCache.getSize;
        NSUInteger nsUrlCacheSize = [[NSURLCache sharedURLCache] currentDiskUsage];
        NSUInteger qcNetworkCache = [QCNetworkCache totalDiskCacheSize];
        NSUInteger qcNetworkDownloadCache = [QCNetworkCache totalDownloadDataSize];

        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f M", (sdWebImageCacheSize + nsUrlCacheSize + qcNetworkCache + qcNetworkDownloadCache) / (1024.0 * 1024.0)];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSDictionary *dict = self.dataSource[indexPath.section][indexPath.row];

    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", dict[@"detail"]]]];
        }else{
            QCWebViewController *webView = [QCWebViewController webViewWithUrl:dict[@"link"]];
            [self.navigationController pushViewController:webView animated:YES];
        }
    }else{
        [[[SDWebImageManager sharedManager] imageCache] clearDisk];
        [[[SDWebImageManager sharedManager] imageCache] clearMemory];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [QCNetworkCache clearAllCache];
        [QCNetworkCache clearDownloadData];
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }
}

@end
