//
//  QCSheetView.m
//  QCAlertView
//
//  Created by Joe-c on 16/8/17.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCSheetView.h"
#import "NSString+StringSize.h"

#define kRowHeight 50
#define kMargin 5
#define kHeaderViewHeight [self messageSize].height + 30
#define kLineColor [UIColor colorWithWhite:0.667 alpha:1.000]

@interface QCSheetView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView  *blackView;
//@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation QCSheetView

+ (instancetype)showSheetViewWithMessage:(NSString *)message andButtonsTitle:(NSArray *)buttonsTitle alertViewblock:(alertViewClickOption)alertViewblock{
    QCSheetView *sheetView = [QCSheetView new];
    sheetView.buttonsTitle = buttonsTitle;
    sheetView.contentView = [[[UIApplication sharedApplication] delegate] window];
    sheetView.message = message;
    sheetView.alertViewblock = alertViewblock;
    [sheetView show];
    return sheetView;
}

- (void)setContentView:(UIView *)contentView {
    
    self.frame = contentView.bounds;
    [super setContentView:contentView];
}

- (void)show {
    
    if (self.contentView) {
        [self.contentView addSubview:self];
        
        [self createBlackView];
        [self createTableView];
    }
}

- (void)hide {
    
    if (self.contentView) {
        
        [self removeViews];
    }
}

- (void)createBlackView {
    
    self.blackView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.blackView.backgroundColor = [UIColor blackColor];
    self.blackView.alpha = 0;
    [self addSubview:self.blackView];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.blackView.alpha = 0.25f;
    }];
}


- (void)createTableView {
    
    CGFloat bottomH = (self.buttonsTitle.count + 1) * kRowHeight + kMargin + (!self.message.length ? 0 : kHeaderViewHeight);
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, bottomH) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor lightTextColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = kRowHeight;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorColor = kLineColor;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[self description]];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self addSubview:self.tableView];
    
    __block CGPoint center = self.tableView.center;
    center.y -= bottomH + 10;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         weakSelf.tableView.center = center;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1
                                               delay:0.0
                                             options:UIViewAnimationOptionAllowUserInteraction
                                          animations:^{
                                              center.y += 10;
                                              weakSelf.tableView.center = center;
                                          } completion:nil];
                     }];

}

- (void)removeViews {
    CGPoint center = self.tableView.center;
    center.y += self.tableView.bounds.size.height;
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.blackView.alpha = 0.f;
                         self.tableView.center = center;
                     } completion:^(BOOL finished) {
                         [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                         [self removeFromSuperview];
                     }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hide];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section ? 1 : self.buttonsTitle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self description] forIndexPath:indexPath];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = FontWithSize(15.f);
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    cell.textLabel.text = indexPath.section ? @"取消" : self.buttonsTitle[indexPath.row];
    cell.textLabel.textColor = !indexPath.section && !indexPath.row ? [UIColor redColor] : [UIColor blackColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section ? kMargin : self.message.length ? kHeaderViewHeight : CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSUInteger index = indexPath.section ? 0 : indexPath.row + 1;
    !self.alertViewblock ? : self.alertViewblock(index);
    [self hide];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerTitleView = [UIView new];
    headerTitleView.backgroundColor = [UIColor whiteColor];
    {
        UILabel *titleLabel = [UILabel new];
        titleLabel.frame = CGRectMake(15, 15, kScreenWidth - 30, [self messageSize].height);
        titleLabel.text = self.message;
        titleLabel.textColor = kColor;
        titleLabel.font = FontWithSize(13.f);
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [headerTitleView addSubview:titleLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeaderViewHeight, kScreenWidth, .5)];
        lineView.backgroundColor = kLineColor;
        [headerTitleView addSubview:lineView];
    }
    
    return section || !self.message.length? nil : headerTitleView;
}

- (CGSize)messageSize{
    return [self.message sizeWithAttribute:@{NSFontAttributeName : FontWithSize(13.f)} width:kScreenWidth - 30];
}
@end
