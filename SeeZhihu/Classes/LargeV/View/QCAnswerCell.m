//
//  QCAnswerCell.m
//  SeeZhiHu
//
//  Created by Joe on 16/7/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCAnswerCell.h"
#import <PureLayout.h>
#import "QCTopanswers.h"

@interface QCAnswerCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIButton *agreeBtn;
@end


@implementation QCAnswerCell

+ (instancetype)cellWithTableView:(UITableView *)tableView topanswers:(QCTopanswers *)topanswers{
    QCAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:[QCAnswerCell description]];
    if (!cell) {
        cell = [[QCAnswerCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[QCAnswerCell description]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.topanswers = topanswers;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.titleLabel];
        
        self.dateLabel = [UILabel new];
        self.dateLabel.font = [UIFont systemFontOfSize:11];
        self.dateLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.dateLabel];
        
        self.agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.agreeBtn.userInteractionEnabled = NO;
        [self.agreeBtn setImage:[UIImage imageNamed:@"vote"] forState:UIControlStateNormal];
        [self.agreeBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
        [self.agreeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.agreeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [self.agreeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [self.contentView addSubview:self.agreeBtn];
        
        [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        
        [self.agreeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [self.agreeBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
        [self.agreeBtn autoSetDimensionsToSize:CGSizeMake(70, 20)];
        [self.agreeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel withOffset:10];
        
        [self.dateLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.agreeBtn withOffset:-10];
        [self.dateLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.agreeBtn];
    }
    return self;
}

- (void)setTopanswers:(QCTopanswers *)topanswers{
    _topanswers = topanswers;
    
    self.titleLabel.text = topanswers.title;
    self.dateLabel.text = topanswers.date;
    [self.agreeBtn setTitle:topanswers.agree forState:UIControlStateNormal];
}

@end
