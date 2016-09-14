//
//  QCPostsCell.h
//  SeeZhiHu
//
//  Created by Joe on 16/7/25.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QCPosts;

@interface QCPostsCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView post:(QCPosts *)post;
@property (nonatomic, strong) QCPosts *post;

@end
