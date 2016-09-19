//
//  QCVoteCell.m
//  SeeZhiHu
//
//  Created by Joe on 16/7/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCRankCell.h"
#import "QCRank.h"
#import <PureLayout.h>
#import "QCUtilsMacro.h"
#import "UIImageView+WebImage.h"

@interface QCRankCell ()

@property (nonatomic, strong) UIImageView *avatarImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *signatureLabel;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *numberLabel;

@end

@implementation QCRankCell

+ (instancetype)cellWithTableView:(UITableView *)tableView QCRank:(QCRank *)rank{
    QCRankCell *cell = [tableView dequeueReusableCellWithIdentifier:[QCRankCell description]];
    if (!cell) {
        cell = [[QCRankCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[QCRankCell description]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.rank = rank;
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.avatarImg = [UIImageView new];
    self.avatarImg.layer.cornerRadius = 30;
    self.avatarImg.layer.masksToBounds = YES;
    [self.contentView addSubview:self.avatarImg];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.nameLabel];
    
    self.signatureLabel = [UILabel new];
    self.signatureLabel.font = [UIFont systemFontOfSize:14];
    self.signatureLabel.textColor = [UIColor grayColor];
    self.signatureLabel.numberOfLines = 2;
    [self.contentView addSubview:self.signatureLabel];
    
    self.containerView = [UIView new];
    self.containerView.layer.cornerRadius = 7;
    self.containerView.layer.masksToBounds = YES;
    self.containerView.layer.borderColor = [UIColor colorWithWhite:0.810 alpha:1.000].CGColor;
    self.containerView.layer.borderWidth = .5f;
    [self.contentView addSubview:self.containerView];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.backgroundColor = KeyColor;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.containerView addSubview:self.titleLabel];
    
    self.numberLabel = [UILabel new];
    self.numberLabel.font = [UIFont systemFontOfSize:12];
    [self.containerView addSubview:self.numberLabel];
    
    [self.avatarImg autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.avatarImg autoSetDimensionsToSize:CGSizeMake(60, 60)];
    [self.avatarImg autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    
    [self.nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.avatarImg withOffset:10];
    [self.nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.avatarImg];
    
    [self.signatureLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.nameLabel];
    [self.signatureLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.avatarImg];
    [self.signatureLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.containerView withOffset:-10];
    
    [self.containerView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.avatarImg];
    [self.containerView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [self.containerView autoSetDimensionsToSize:CGSizeMake(55, 60)];
    
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.titleLabel autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.containerView withMultiplier:.5];

    [self.numberLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.numberLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
}

- (void)setRank:(QCRank *)rank{
    _rank = rank;
    
    [self.avatarImg qc_avatarImageWithUrlString:rank.avatar placeholderImageString:@"icon_placeholder" showProgress:NO];
    self.nameLabel.text = rank.name;
    self.signatureLabel.text = rank.signature;
    self.titleLabel.text = rank.rankTyleStr;
    self.numberLabel.text = [NSString stringWithFormat:@"%li", rank.follower ? rank.follower : rank.agree];
}

@end
