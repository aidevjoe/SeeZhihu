//
//  QCSearchUserCell.h
//  SeeZhiHu
//
//  Created by Joe on 16/7/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QCRank;
@interface QCSearchUserCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView user:(QCRank *)user;
@property (nonatomic, strong) QCRank *user;

@end
