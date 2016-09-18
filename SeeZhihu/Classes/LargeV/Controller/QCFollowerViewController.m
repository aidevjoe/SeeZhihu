//
//  QCFollowerViewController.m
//  SeeZhiHu
//
//  Created by Joe on 16/7/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCFollowerViewController.h"
#import "QCNetworking.h"
#import "QCRank.h"
#import <YYModel.h>
#import "QCUtilsMacro.h"

@implementation QCFollowerViewController


#pragma mark - life cycle...

- (void)viewDidLoad {
    [super viewDidLoad];

    [QCNetworking getRequestWithUrl:@"http://api.kanzhihu.com/topuser/follower/1" params:nil cache:YES refresh:YES successBlock:^(id returnData, int code, NSString *msg) {
        NSMutableArray *voteArr = [NSMutableArray array];
        for (NSDictionary *vote in returnData[@"topuser"]) {
            [voteArr addObject:[QCRank yy_modelWithJSON:vote]];
        }
        self.rankData = voteArr;
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);

    } showHUD:NO];
}
@end
