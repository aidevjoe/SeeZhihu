//
//  QCMessageAlertView.m
//  QCAlertView
//
//  Created by Joe on 16/8/17.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCMessageAlertView.h"
#import "NSString+StringSize.h"

@interface QCMessageAlertView () 

@property (nonatomic, strong)  UIView  *blackView;
@property (nonatomic, strong)  UIView  *messageView;

@end

@implementation QCMessageAlertView

+ (instancetype)shareInstance{
    static QCMessageAlertView *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[QCMessageAlertView alloc] init];
    });
    return shareInstance;
}

+ (instancetype)showAlertWithMessage:(NSString *)message{
    return [QCMessageAlertView showAlertWithContentView:[[[UIApplication sharedApplication] delegate] window] andMessage:message];
}

+ (instancetype)showAlertWithMessage:(NSString *)message Complete:(alertViewDidDismiss)alertViewDidDismiss{
    QCMessageAlertView *alertView = [QCMessageAlertView showAlertWithMessage:message];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(alertView.delayAutoHidenDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        !alertViewDidDismiss ? : alertViewDidDismiss();
    });
    return alertView;
}


+ (instancetype)showAlertWithContentView:(UIView *)contentView andMessage:(NSString *)message{
    QCMessageAlertView *alertView = [[QCMessageAlertView alloc] init];
    if (!message) message = @"";
    if (![message isKindOfClass:[NSString class]]) message = @"";
    alertView.message = message;
    alertView.contentView = contentView;
    [alertView show];
    return alertView;
}

- (void)setContentView:(UIView *)contentView {
    
    self.frame = contentView.bounds;
    [super setContentView:contentView];
}

- (void)show {
    
    if (self.contentView) {
        [self.contentView addSubview:self];
        self.contentView.userInteractionEnabled = NO;
        [self createBlackView];
        [self createMessageView];
        
        if (self.autoHiden) {
            [self performSelector:@selector(hide) withObject:nil afterDelay:self.delayAutoHidenDuration];
        }
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

- (void)createMessageView {
    
    //计算文字宽高
    CGSize messageSize = [self.message sizeWithAttribute:@{NSFontAttributeName : FontWithSize(17.f)} width:kScreenWidth - 90];
    
    // 创建信息label
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, messageSize.width, messageSize.height)];
    textLabel.text = self.message;
    textLabel.font = FontWithSize(17.f);
    textLabel.textColor = [UIColor whiteColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.numberOfLines = 0;
    [textLabel sizeToFit];
    
    // 创建信息窗体view
    self.messageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, messageSize.width + 20, messageSize.height + 10)];
    self.messageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    self.messageView.center = CGPointMake(CGRectGetWidth(self.contentView.bounds) / 2.f, CGRectGetHeight(self.contentView.bounds) / 2.f);
    textLabel.center = CGPointMake(CGRectGetWidth(self.messageView.bounds) / 2.f, CGRectGetHeight(self.messageView.bounds) / 2.f);
    self.messageView.alpha = 0.f;
    [self.messageView addSubview:textLabel];
    [self addSubview:self.messageView];
    
    // 执行动画
    [UIView animateWithDuration:.3f animations:^{
        self.messageView.alpha = 1.f;
    }];
    
    CASpringAnimation * scale = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = [NSValue valueWithCGSize:CGSizeMake(1.75f, 1.75f)];
    scale.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scale.stiffness = 80;
    scale.mass = .8;
    scale.damping = 5;
    scale.duration = 1.f;
    scale.speed = 2.f;
    scale.delegate = self;
    [self.messageView.layer addAnimation:scale forKey:scale.keyPath];
}

- (void)removeViews {
    [UIView animateWithDuration:0.2f animations:^{
        self.blackView.alpha = 0.f;
        self.messageView.alpha = 0.f;
        self.messageView.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
        
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.contentView.userInteractionEnabled = YES;
}

@end
