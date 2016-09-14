//
//  QCPostsCell.m
//  SeeZhiHu
//
//  Created by Joe on 16/7/25.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCPostsCell.h"
#import "QCPosts.h"
#import <PureLayout.h>
#import "QCUtilsMacro.h"
#import "UIImageView+WebImage.h"

@interface QCPostsCell ()

@property (nonatomic, strong) UILabel *archivedTypeLabel;
@property (nonatomic, strong) UIImageView *dateImage;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *descriptionLabel;
@end

@implementation QCPostsCell

-(void)setFrame:(CGRect)frame{
    frame.origin.x = 10;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= frame.origin.x;
    [super setFrame:frame];
}



+ (instancetype)cellWithTableView:(UITableView *)tableView post:(QCPosts *)post{
    QCPostsCell *cell = [tableView dequeueReusableCellWithIdentifier:[QCPostsCell description]];
    if (!cell) {
        cell = [[QCPostsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[QCPostsCell description]];
        cell.layer.cornerRadius = 20;
        cell.layer.masksToBounds = YES;
        cell.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        cell.layer.borderWidth = 1.f;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.post = post;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    
    return self;
}


- (void)setup{
    self.archivedTypeLabel = [UILabel new];
    self.archivedTypeLabel.font = [UIFont systemFontOfSize:12];
    self.archivedTypeLabel.textColor = KeyColor;
    self.archivedTypeLabel.layer.borderColor = KeyColor.CGColor;
    self.archivedTypeLabel.layer.borderWidth = 1;
    self.archivedTypeLabel.textAlignment = NSTextAlignmentCenter;
    self.archivedTypeLabel.layer.cornerRadius = 3;
    self.archivedTypeLabel.layer.masksToBounds = YES;
    [self.contentView addSubview:self.archivedTypeLabel];
    
    self.dateImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"date"]];
    [self.contentView addSubview:self.dateImage];
    
    self.dateLabel = [UILabel new];
    self.dateLabel.font = [UIFont systemFontOfSize:13];
    self.dateLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.dateLabel];
    
    self.iconView = [UIImageView new];
    self.iconView.backgroundColor = HexColor(@"E2E2E2");
    [self.contentView addSubview:self.iconView];
    
    self.descriptionLabel = [UILabel new];
    self.descriptionLabel.numberOfLines = 6;
    self.descriptionLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.descriptionLabel];
 
    [self.archivedTypeLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [self.archivedTypeLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [self.archivedTypeLabel autoSetDimensionsToSize:CGSizeMake(60, 20)];
    
    [self.dateLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [self.dateLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.archivedTypeLabel];
    
    [self.dateImage autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.dateLabel withOffset:-5];
    [self.dateImage autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.dateLabel];
    [self.dateImage autoSetDimensionsToSize:CGSizeMake(23, 22)];
    
    [self.descriptionLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.archivedTypeLabel];
    [self.descriptionLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.dateLabel];
    [self.descriptionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.archivedTypeLabel withOffset:10];
    
    [self.iconView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [self.iconView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [self.iconView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.descriptionLabel withOffset:10];
    [self.iconView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:self.iconView withMultiplier:.5];
    [self.iconView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];

//    [self.iconView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
//    [self.iconView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.archivedTypeLabel withOffset:10];
//    [self.iconView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
//    [self.iconView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:self.iconView withMultiplier:.5];
//    
//    [self.descriptionLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.iconView];
//    [self.descriptionLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.iconView];
//    [self.descriptionLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
//    [self.descriptionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.iconView withOffset:10];
}

- (void)setPost:(QCPosts *)post{
    _post = post;
    
    self.archivedTypeLabel.text = post.postName;
    self.dateLabel.text = post.date;
    self.descriptionLabel.text = post.excerpt;
    
    WeakSelf;
    [self.iconView qc_imageWithUrlString:post.pic placeholderImageString:nil showProgress:YES completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        weakSelf.iconView.alpha = 0;
        weakSelf.iconView.transform = CGAffineTransformMakeScale(.75, .75);
        
        [UIView animateWithDuration:0.5f animations:^{
            weakSelf.iconView.alpha = 1.f;
            weakSelf.iconView.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }];
}



@end
