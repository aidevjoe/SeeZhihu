//
//  QCSliderView.h
//  QCMiaoBo
//
//  Created by Joe on 16/7/18.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QCSliderView : UIView

@property (nonatomic, copy) void (^didSelectedTitleBtn)(NSInteger);

+ (QCSliderView *)sliderViewWithTitles:(NSArray *)titles;
- (QCSliderView *)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

- (void)setSelectedBtnWithIndex:(NSInteger)index;
@property (nonatomic, strong) UIView *lineV;

@end
