//
//  QCButtonsAlertView.m
//  QCAlertView
//
//  Created by Joe on 16/8/17.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCButtonsAlertView.h"


@interface QCButtonsAlertView ()

@property (nonatomic, strong) UIButton  *firstButton;
@property (nonatomic, strong) UIButton  *secondButton;
@property (nonatomic, strong) UIView    *blackView;
@property (nonatomic, strong) UIView    *messageView;

@end

@implementation QCButtonsAlertView

+ (instancetype)shareInstance{
    static QCButtonsAlertView *shareInstance  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[QCButtonsAlertView alloc] init];
    });
    
    return shareInstance;
}

+ (UIView *)lineViewWithFrame:(CGRect)frame color:(UIColor *)color {
    
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = color;
    
    return line;
}


+ (instancetype)showAlertWithMessage:(NSString *)message{
    return [QCButtonsAlertView showAlertWithContentView:[[[UIApplication sharedApplication] delegate] window] andMessage:message];
}

+ (instancetype)showAlertWithContentView:(UIView *)contentView andMessage:(NSString *)message{
    return [QCButtonsAlertView showAlertWithContentView:contentView andMessage:message andButtonsTitle:nil];
}

+ (instancetype)showAlertWithContentView:(UIView *)contentView andMessage:(NSString *)message andButtonsTitle:(NSArray *)buttonsTitle{
    QCButtonsAlertView *showView = [QCButtonsAlertView shareInstance];
    showView.contentView = contentView;
    showView.buttonsTitle = buttonsTitle;
    showView.message = message;
    [showView show];
    return showView;
}

+ (instancetype)showAlertWithContentView:(UIView *)contentView andMessage:(NSString *)message andButtonsTitle:(NSArray *)buttonsTitle alertViewblock:(alertViewClickOption)alertViewblock{
    QCButtonsAlertView *showView = [QCButtonsAlertView showAlertWithContentView:contentView andMessage:message andButtonsTitle:buttonsTitle];
    showView.alertViewblock = alertViewblock;
    return showView;
}

- (instancetype)init {
    
    if (self = [super init]) {
        self.firstButton = [[UIButton alloc] initWithFrame:CGRectZero];
        self.secondButton = [[UIButton alloc] initWithFrame:CGRectZero];
        
        self.firstButton.tag = 0;
        self.firstButton.titleLabel.font = FontWithSize(16.f);
        [self.firstButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.firstButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.firstButton addTarget:self action:@selector(messageButtonsEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        self.secondButton.tag = 1;
        self.secondButton.titleLabel.font = FontWithSize(16.f);
        [self.secondButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.secondButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.secondButton addTarget:self action:@selector(messageButtonsEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        [self setView:self.firstButton  withKey:@"firstButton"];
        [self setView:self.secondButton withKey:@"secondButton"];
    }
    
    return self;
}

- (void)setContentView:(UIView *)contentView {
    
    [super setContentView:contentView];
    self.frame = contentView.bounds;
}

- (void)show {
    
    if (self.contentView) {
        [self.contentView addSubview:self];
        self.contentView.userInteractionEnabled = NO;
        [self createBlackView];
        [self createMessageView];
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
    
    // 创建信息label
    NSString *text = self.message;
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 210, 0)];
    textLabel.text = text;
    textLabel.font = FontWithSize(15.f);
    textLabel.textColor = [UIColor blackColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.numberOfLines = 0;
    [textLabel sizeToFit];
    
    // 创建信息窗体view
    self.messageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240, textLabel.bounds.size.height + 80)];
    self.messageView.backgroundColor = [UIColor whiteColor];
    self.messageView.layer.cornerRadius = 10.f;
    self.messageView.center = CGPointMake(CGRectGetWidth(self.contentView.bounds) / 2.f, CGRectGetHeight(self.contentView.bounds) / 2.f);
    textLabel.center = CGPointMake(CGRectGetWidth(self.messageView.bounds) * .5f,  (CGRectGetHeight(self.messageView.bounds) - 40) * .5f);
    self.messageView.alpha = 0.f;
    [self.messageView addSubview:textLabel];
    [self addSubview:self.messageView];
    
    // 处理按钮
    NSArray *buttonsInfo = self.buttonsTitle.count <= 2 ? self.buttonsTitle : [self.buttonsTitle subarrayWithRange:NSMakeRange(0, 2)];
    
    if (buttonsInfo.count == 0) {
        self.messageView.frame = CGRectMake(0, 0, textLabel.bounds.size.width + 20, textLabel.bounds.size.height + 10);
        //        self.messageView.backgroundColor        = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        self.messageView.center = CGPointMake(CGRectGetWidth(self.contentView.bounds) / 2.f, CGRectGetHeight(self.contentView.bounds) / 2.f);
        self.messageView.layer.cornerRadius = 0.f;
        textLabel.center = CGPointMake(CGRectGetWidth(self.messageView.bounds) / 2.f, CGRectGetHeight(self.messageView.bounds) / 2.f);
        textLabel.textColor = [UIColor blackColor];
        
        [self performSelector:@selector(hide) withObject:nil afterDelay:self.delayAutoHidenDuration];
    }
    
    // 如果有1个按钮
    if (buttonsInfo.count == 1) {
        [self.messageView addSubview:[[self class] lineViewWithFrame:CGRectMake(0, self.messageView.bounds.size.height - 40, self.messageView.bounds.size.width, 0.5f) color:kColor]];
        
        self.firstButton.frame = CGRectMake(0, self.messageView.bounds.size.height - 40, self.messageView.bounds.size.width, 40);
        self.firstButton.titleLabel.font = FontWithSize(16.f);
        self.firstButton.exclusiveTouch = YES;
        [self.firstButton setTitle:self.buttonsTitle[0] forState:UIControlStateNormal];
        [self.firstButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.firstButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.firstButton addTarget:self action:@selector(messageButtonsEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.messageView addSubview:self.firstButton];
    }
    
    // 如果有2个按钮
    if (buttonsInfo.count == 2) {
        [self.messageView addSubview:[[self class] lineViewWithFrame:CGRectMake(0, self.messageView.bounds.size.height - 40, self.messageView.bounds.size.width, 0.5f) color:kColor]];
        [self.messageView addSubview:[[self class] lineViewWithFrame:CGRectMake(self.messageView.bounds.size.width / 2.f, self.messageView.bounds.size.height - 40, 0.5f, 40.f) color:kColor]];
        
        self.firstButton.frame = CGRectMake(0, self.messageView.bounds.size.height - 40, self.messageView.bounds.size.width / 2.f, 40);
        self.firstButton.exclusiveTouch = YES;
        [self.firstButton setTitle:self.buttonsTitle[0] forState:UIControlStateNormal];
        [self.messageView addSubview:self.firstButton];
        
        self.secondButton.frame = CGRectMake(self.messageView.bounds.size.width / 2.f, self.messageView.bounds.size.height - 40, self.messageView.bounds.size.width / 2.f, 40);
        self.secondButton.exclusiveTouch = YES;
        [self.secondButton setTitle:self.buttonsTitle[1] forState:UIControlStateNormal];
        [self.messageView addSubview:self.secondButton];
    }
    
    // 执行动画
    [UIView animateWithDuration:.3f animations:^{
        self.messageView.alpha = 1.f;
    }];
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = [NSValue valueWithCGSize:CGSizeMake(1.3f, 1.3f)];
    scale.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scale.delegate = self;
    [self.messageView.layer addAnimation:scale forKey:scale.keyPath];
    
//    CASpringAnimation * scale = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
//    scale.fromValue = [NSValue valueWithCGSize:CGSizeMake(1.3f, 1.3f)];
//    scale.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
//    scale.mass = 2.f;
//    scale.damping = 20.f;
//    scale.duration = scale.settlingDuration;
//    scale.speed = 3;
//    scale.stiffness = 70;
//    scale.delegate = self;
//    [self.messageView.layer addAnimation:scale forKey:scale.keyPath];
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

- (void)messageButtonsEvent:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:clickAtIndex:data:)]) {
        [self.delegate alertView:self clickAtIndex:button.tag data:nil];
    }
    
    !self.alertViewblock ? : self.alertViewblock(button.tag);
    
    [self hide];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.contentView.userInteractionEnabled = YES;
}

@end
