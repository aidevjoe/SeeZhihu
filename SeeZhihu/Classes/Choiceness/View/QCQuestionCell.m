//
//  QCQuestionCell.m
//  SeeZhiHu
//
//  Created by Joe on 16/7/25.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCQuestionCell.h"
#import <PureLayout.h>
#import "QCQuestion.h"
#import "QCUtilsMacro.h"
#import "QCCellDataAdapter.h"
#import "QCWebViewController.h"
#import "NSString+LabelWidthAndHeight.h"
#import "UIImageView+WebImage.h"

@interface QCQuestionCell ()

@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) UILabel *authornameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *summaryLabel;
@property (nonatomic, strong) UIButton *voteBtn;

@end

@implementation QCQuestionCell

-(void)setFrame:(CGRect)frame{
    frame.origin.x = 10;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= frame.origin.x;
    [super setFrame:frame];
}

- (void)setupCell{
    self.layer.cornerRadius = 20;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.layer.borderWidth = 1.f;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview{
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.titleLabel];
    
    self.avatarImage = [UIImageView new];
    self.avatarImage.layer.cornerRadius = 18.5;
    self.avatarImage.layer.masksToBounds = YES;
    [self.contentView addSubview:self.avatarImage];
    
    self.authornameLabel = [UILabel new];
    self.authornameLabel.font = [UIFont systemFontOfSize:13];
    self.authornameLabel.textColor = [UIColor grayColor];
    self.authornameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.authornameLabel];
    
    self.summaryLabel = [UILabel new];
    self.summaryLabel.font = [UIFont systemFontOfSize:12];
    self.summaryLabel.numberOfLines = 0;
    self.summaryLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.summaryLabel];
    
    self.voteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.voteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.voteBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.voteBtn setImage:[UIImage imageNamed:@"vote"] forState:UIControlStateNormal];
    self.voteBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.voteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.voteBtn setEnabled:YES];
    self.voteBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    [self.contentView addSubview:self.voteBtn];
    
    [self.avatarImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [self.avatarImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [self.avatarImage autoSetDimensionsToSize:CGSizeMake(37, 37)];
    
    [self.authornameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.avatarImage withOffset:5];
    [self.authornameLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.avatarImage];
    
    [self.voteBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [self.voteBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.avatarImage];
    [self.voteBtn autoSetDimensionsToSize:CGSizeMake(60, 30)];
    
    [self.titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.avatarImage withOffset:10];
    [self.titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.avatarImage];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    
    [self.summaryLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel withOffset:10];
    [self.summaryLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.titleLabel];
    [self.summaryLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.titleLabel];
//    [self.summaryLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];

}

+ (CGFloat)cellHeightWithData:(id)data{
    
    if (!data) return 0.0f;
    
    QCQuestion *question = data;
    
    CGFloat w = ScreenWidth - 40;
    
    //头像顶部间距 + 头像高度 + 头像和标题间距 + 标题和详情间距 + 详情底部间距 + setFrame中减掉的高度
    CGFloat height = 5 + 37 + 10 + 10 + 10 + 10;
    height += [question.title heightWithStringAttribute:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} fixedWidth:w];
    height += [question.summary heightWithStringAttribute:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} fixedWidth:w];
    
    return height;
}

- (void)loadContent{
    
    QCQuestion *question = self.data;
    
    self.titleLabel.text = question.title;
    self.summaryLabel.text = question.summary;
    [self.avatarImage qc_avatarImageWithUrlString:question.avatar placeholderImageString:@"icon_placeholder" showProgress:NO];
    self.authornameLabel.text = question.authorname;
    [self.voteBtn setTitle:question.vote forState:UIControlStateNormal];
}

- (void)selectedEvent{
    QCQuestion *question = self.data;
    QCWebViewController *webVc = [QCWebViewController webViewWithUrl:[NSString stringWithFormat:@"https://www.zhihu.com/question/%@/answer/%@", question.questionid, question.answerid] title:question.title];
    [self.controller.navigationController pushViewController:webVc animated:YES];
}
@end
