//
//  QCUserInfoHeaderView.m
//  SeeZhiHu
//
//  Created by Joe on 16/7/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCUserInfoHeaderView.h"
#import "QCUtilsMacro.h"
#import <PureLayout.h>
#import "QCUserInfo.h"
#import "UIImageView+WebImage.h"
#import "QCDetail.h"

@interface QCUserInfoHeaderView ()

@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *signatureLabel;
@property (nonatomic, strong) UILabel *followerAndAgreeLabel;

@end

@implementation QCUserInfoHeaderView


+ (instancetype)headerViewWithUserInfo:(QCUserInfo *)userInfo{
    return [[self alloc] initWithUserInfo:userInfo];;
}

- (instancetype)initWithUserInfo:(QCUserInfo *)userInfo{
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, ScreenWidth, 140);
        self.backgroundColor = [UIColor colorWithWhite:0.966 alpha:1.000];
        
        self.avatarImage = [UIImageView new];
        self.avatarImage.layer.cornerRadius = 30;
        self.avatarImage.layer.masksToBounds = YES;
        [self addSubview:self.avatarImage];
        
        self.nameLabel = [UILabel new];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.nameLabel];
        
        self.signatureLabel = [UILabel new];
        self.signatureLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.signatureLabel];
        
        self.followerAndAgreeLabel = [UILabel new];
        self.followerAndAgreeLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.followerAndAgreeLabel];
        
        [self.avatarImage autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.avatarImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        [self.avatarImage autoSetDimensionsToSize:CGSizeMake(60, 60)];
        
        [self.nameLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.avatarImage];
        [self.nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.avatarImage withOffset:5];
        
        [self.signatureLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.avatarImage];
        [self.signatureLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:5];
        
        [self.followerAndAgreeLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.avatarImage];
        [self.followerAndAgreeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.signatureLabel withOffset:5];
        
        self.userInfo = userInfo;
    }
    return self;
}

- (void)setUserInfo:(QCUserInfo *)userInfo{
    _userInfo = userInfo;
    
    [self.avatarImage qc_avatarImageWithUrlString:userInfo.avatar placeholderImageString:@"icon_placeholder" showProgress:NO];
    self.nameLabel.text = userInfo.name;
    self.signatureLabel.text = userInfo.signature;
    self.followerAndAgreeLabel.text = [NSString stringWithFormat:@"获得 %@赞同 %@感谢 %@关注", userInfo.detail.agree, userInfo.detail.thanks, userInfo.detail.follower];
}

@end
