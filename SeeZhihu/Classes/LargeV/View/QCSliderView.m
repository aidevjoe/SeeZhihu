//
//  QCSliderView.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/18.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCSliderView.h"
#import "QCUtilsMacro.h"

@interface QCSliderView ()


@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation QCSliderView


- (QCSliderView *)initWithFrame:(CGRect)frame titles:(NSArray *)titles{
    if (self = [super initWithFrame:frame]) {
        self.tag = 111;
        self.frame = CGRectMake(0, 0, 140, 38);
        CGFloat btnW = self.width / titles.count;
        CGFloat btnH = self.height;
        CGFloat btnX = 0;
        for (int i = 0; i < titles.count; i ++) {
            UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
            [titleBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
            [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            titleBtn.tag = i;
            btnX = i * btnW;
            titleBtn.frame = CGRectMake(btnX, 0, btnW, btnH);
            [titleBtn addTarget:self action:@selector(clickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:titleBtn];
            
            if (i == 0) {
                titleBtn.selected = YES;
                self.selectedBtn = titleBtn;
                
                UIView *lineV = [UIView new];
                [titleBtn.titleLabel sizeToFit];
                lineV.frame = CGRectMake(0, 36, titleBtn.titleLabel.width + 10, 2);
                lineV.centerX = titleBtn.centerX;
                lineV.backgroundColor = [UIColor whiteColor];
                [self addSubview:lineV];
                self.lineV = lineV;
            }
        }
    }
    return self;
}

+ (QCSliderView *)sliderViewWithTitles:(NSArray *)titles{
    return [[QCSliderView alloc] initWithFrame:CGRectZero titles:titles];
}

- (void)clickTitleBtn:(UIButton *)btn{
    if (btn == self.selectedBtn) return;
    
    !self.didSelectedTitleBtn ? : self.didSelectedTitleBtn(btn.tag);
    
//    [self setSelectedBtnWithIndex:btn.tag];
}

- (void)setSelectedBtnWithIndex:(NSInteger)index{
    UIButton *btn = [self viewWithTag:index];
    
    [UIView animateWithDuration:.25 animations:^{
        self.lineV.centerX = btn.centerX;
    }];
    
    self.selectedBtn.selected = NO;
    
    btn.selected = YES;
    
    self.selectedBtn = btn;
}
@end
