//
//  UIImageView+WebImage.m
//  SeeZhiHu
//
//  Created by Joe on 16/8/8.
//  Copyright © 2016年 Joe-c. All rights reserved.
//

#import "UIImageView+WebImage.h"
#import "UIImage+extension.h"
#import "CircleProgressBar.h"
#import "QCUtilsMacro.h"

#define kProgressTag 130

@implementation UIImageView (WebImage)


- (void)qc_addProgressView{
    CircleProgressBar *existingProgressView = (CircleProgressBar *)[self viewWithTag:kProgressTag];
    if (!existingProgressView) {
        float width = 50;
        float height = 50;
        float x = (self.frame.size.width * .5) - width * .5;
        float y = (self.frame.size.height * .5) - height * .5;
        CircleProgressBar *progressView = [[CircleProgressBar alloc] initWithFrame:CGRectMake(x, y, width, height)];
        progressView.tag = kProgressTag;
        progressView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        progressView.backgroundColor = [UIColor clearColor];
        
        [progressView setProgressBarWidth:(6.0f)];
        [progressView setProgressBarProgressColor:(KeyColor)];
        [progressView setProgressBarTrackColor:([UIColor colorWithWhite:0.000 alpha:0.800])];
        
        [progressView setHintViewSpacing:(10.0f)];
        [progressView setHintViewBackgroundColor:[UIColor clearColor]];
        [progressView setHintTextFont:([UIFont fontWithName:@"AvenirNextCondensed-Heavy" size:10.0f])];
        [progressView setHintTextColor:(KeyColor)];
        
        [self addSubview:progressView];
    }
}

- (void)qc_updateProgress:(CGFloat)progress {
    CircleProgressBar *progressView = [self viewWithTag:kProgressTag];
    if (progressView) {
        [progressView setProgress:progress animated:YES];
    }
}

- (void)qc_removeProgressView{
    CircleProgressBar *progressView = [self viewWithTag:kProgressTag];
    if (progressView) {
        [progressView removeFromSuperview];
    }
}

- (void)qc_imageWithUrlString:(NSString *)urlString placeholderImageString:(NSString *)placeholderImageString isAvatar:(BOOL)isAvater showProgress:(BOOL)showProgress  completed:(SDWebImageCompletionBlock)completedBlock{

    showProgress ? [self qc_addProgressView] : 0 ;
    
    __weak typeof(self) weakSelf = self;

    [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:placeholderImageString.length ? [UIImage imageNamed:placeholderImageString] : nil options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        if (showProgress) {
            CGFloat progress = ((CGFloat)receivedSize / (CGFloat)expectedSize);
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf qc_updateProgress:progress];
            });
        }
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        if (showProgress) {
            [weakSelf qc_removeProgressView];
        }
        
//        if (isAvater) {
//            weakSelf.image = [image imageWithSize:self.bounds.size radius:self.bounds.size.width * .5 backgroundColor:weakSelf.superview.backgroundColor];
//        }else{
//            weakSelf.image = [image imageWithSize:self.bounds.size radius:0 backgroundColor:weakSelf.superview.backgroundColor];
//        }
        
        !completedBlock ? : completedBlock(image, error, cacheType, imageURL);
    }];
}

- (void)qc_avatarImageWithUrlString:(NSString *)urlString placeholderImageString:(NSString *)placeholderImageString showProgress:(BOOL)showProgress {
    [self qc_imageWithUrlString:urlString placeholderImageString:placeholderImageString isAvatar:YES showProgress:showProgress completed:nil];
}

- (void)qc_imageWithUrlString:(NSString *)urlString placeholderImageString:(NSString *)placeholderImageString showProgress:(BOOL)showProgress {
    [self qc_imageWithUrlString:urlString placeholderImageString:placeholderImageString isAvatar:NO showProgress:showProgress completed:nil];
}

- (void)qc_imageWithUrlString:(NSString *)urlString placeholderImageString:(NSString *)placeholderImageString showProgress:(BOOL)showProgress  completed:(SDWebImageCompletionBlock)completedBlock{
    [self qc_imageWithUrlString:urlString placeholderImageString:placeholderImageString isAvatar:NO showProgress:showProgress completed:completedBlock];
}

@end
