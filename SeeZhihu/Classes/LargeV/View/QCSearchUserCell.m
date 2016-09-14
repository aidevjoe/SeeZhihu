//
//  QCSearchUserCell.m
//  SeeZhiHu
//
//  Created by Joe on 16/7/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCSearchUserCell.h"
#import <PureLayout.h>
#import "UIImageView+WebImage.h"
#import "QCRank.h"
#import "QCUtilsMacro.h"

@interface QCSearchUserCell ()

@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *followerNumberLabel;
@property (nonatomic, strong) UILabel *signatureLabel;
@end

@implementation QCSearchUserCell

+ (instancetype)cellWithTableView:(UITableView *)tableView user:(QCRank *)user{
    QCSearchUserCell *cell = [tableView dequeueReusableCellWithIdentifier:[QCSearchUserCell description]];
    if (!cell) {
        cell = [[QCSearchUserCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[QCSearchUserCell description]];
    }
    cell.user = user;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.avatarImage = [UIImageView new];
        self.avatarImage.layer.cornerRadius = 22.5;
        self.avatarImage.layer.masksToBounds = YES;
        [self.contentView addSubview:self.avatarImage];
        
        self.nameLabel = [UILabel new];
        self.nameLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.nameLabel];
        
        self.followerNumberLabel = [UILabel new];
        self.followerNumberLabel.font = [UIFont systemFontOfSize:10];
        self.followerNumberLabel.layer.borderColor = KeyColor.CGColor;
        self.followerNumberLabel.layer.borderWidth = .5f;
        [self.contentView addSubview:self.followerNumberLabel];
        
        self.signatureLabel = [UILabel new];
        self.signatureLabel.numberOfLines = 0;
        self.signatureLabel.font = [UIFont systemFontOfSize:11];
        self.signatureLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.signatureLabel];
        
        [self.avatarImage autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.avatarImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [self.avatarImage autoSetDimensionsToSize:CGSizeMake(45, 45)];
        [self.avatarImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        [self.avatarImage autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
        
        [self.nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.avatarImage];
        [self.nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.avatarImage];
        
        [self.signatureLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.nameLabel];
        [self.signatureLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.avatarImage];
        [self.signatureLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        
        [self.followerNumberLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [self.followerNumberLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nameLabel];
    
    }
    return self;
}

- (void)setUser:(QCRank *)user{
    _user = user;
    
    [self.avatarImage qc_avatarImageWithUrlString:user.avatar placeholderImageString:@"icon_placeholder" showProgress:NO];
    
    self.nameLabel.text = user.name;
    
    self.followerNumberLabel.text = [NSString stringWithFormat:@"粉丝: %li", user.follower];
    
    self.signatureLabel.text = user.signature;
}
@end
