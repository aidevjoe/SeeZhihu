//
//  QCVoteCell.h
//  SeeZhiHu
//
//  Created by Joe on 16/7/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QCRank;

@interface QCRankCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView QCRank:(QCRank *)rank;

@property (nonatomic, strong) QCRank *rank;

@end
