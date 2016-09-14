//
//  QCAnswerCell.h
//  SeeZhiHu
//
//  Created by Joe on 16/7/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QCTopanswers;

@interface QCAnswerCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView topanswers:(QCTopanswers *)topanswers;

@property (nonatomic, strong) QCTopanswers *topanswers;

@end
