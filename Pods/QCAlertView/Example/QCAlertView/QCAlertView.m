//
//  QCAlertView.m
//  QCAlertView
//
//  Created by Joe on 16/8/17.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCAlertView.h"

@interface QCAlertView ()

@property (nonatomic, strong) NSMapTable  *mapTable;

@end

@implementation QCAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.delayAutoHidenDuration = 1.5f;
        self.autoHiden = YES;
        self.mapTable = [NSMapTable strongToWeakObjectsMapTable];
    }
    
    return self;
}

- (void)show {
    
    [NSException raise:@"AlertViewProtocol"
                format:@"Cannot use show method from subclass."];
}

- (void)hide {
    
    [NSException raise:@"AlertViewProtocol"
                format:@"Cannot use hide method from subclass."];
}

- (void)setView:(UIView *)view withKey:(NSString *)key {
    
    [self.mapTable setObject:view forKey:key];
}

- (UIView *)viewWithKey:(NSString *)key {
    
    return [self.mapTable objectForKey:key];
}


@end
