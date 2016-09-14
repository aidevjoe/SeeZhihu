//
//  QCWebViewController.m
//  QCMiaoBo
//
//  Created by Joe on 16/7/19.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "QCWebViewController.h"
#import "UMSocialData.h"
#import "UMSocialSnsService.h"
#import "UMSocialSnsPlatformManager.h"
#import "QCUtilsMacro.h"

@interface QCWebViewController ()<UIWebViewDelegate, UMSocialUIDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy) NSString *url;


@end

@implementation QCWebViewController

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (instancetype)initWithUrl:(NSString *)url title:(NSString *)title{
    if (self = [super init]) {
        [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]]];
        self.title = title;
        self.url = url;
        [self setupNav];
    }
    return self;
}

+ (QCWebViewController *)webViewWithUrl:(NSString *)url{
    return [self webViewWithUrl:url title:nil];
}

+ (QCWebViewController *)webViewWithUrl:(NSString *)url title:(NSString *)title{
    return [[self alloc] initWithUrl:url title:title];
}

- (void)setupNav{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareClick)];
}

- (void)shareClick{
    
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:self.url];
    
    NSString *title = self.title;
    NSString *shareText = self.title;
    NSString *url = self.url;
    
    // Wechat Session
    [UMSocialData defaultData].extConfig.wechatSessionData.urlResource = urlResource;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = shareText;
    [UMSocialData defaultData].extConfig.wechatSessionData.shareImage = [UIImage imageNamed:@"icon"];
    [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
    
    // Wechat Timeline
    [UMSocialData defaultData].extConfig.wechatTimelineData.urlResource = urlResource;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = shareText;
    [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage = [UIImage imageNamed:@"icon"];
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
    
    // Wechat Favorite
    [UMSocialData defaultData].extConfig.wechatFavoriteData.urlResource = urlResource;
    [UMSocialData defaultData].extConfig.wechatFavoriteData.title = title;
    [UMSocialData defaultData].extConfig.wechatFavoriteData.shareText = shareText;
    [UMSocialData defaultData].extConfig.wechatFavoriteData.shareImage = [UIImage imageNamed:@"icon"];
    [UMSocialData defaultData].extConfig.wechatFavoriteData.url = url;
    
    // QQ
    [UMSocialData defaultData].extConfig.qqData.urlResource = urlResource;
    [UMSocialData defaultData].extConfig.qqData.title = title;
    [UMSocialData defaultData].extConfig.qqData.shareText = shareText;
    [UMSocialData defaultData].extConfig.qqData.url = url;
    [UMSocialData defaultData].extConfig.qqData.shareImage = [UIImage imageNamed:@"icon"];
    
    // Sina Weibo
    [UMSocialData defaultData].extConfig.sinaData.urlResource = urlResource;
    [UMSocialData defaultData].extConfig.sinaData.shareImage = [UIImage imageNamed:@"icon"];
    [UMSocialData defaultData].extConfig.sinaData.shareText = [NSString stringWithFormat:@"#看知乎# %@ %@", shareText, url];
    
    NSArray *snsNames = @[ UMShareToWechatSession, UMShareToWechatTimeline, UMShareToWechatFavorite, UMShareToQQ, UMShareToSina];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UmengAppkey
                                      shareText:nil
                                     shareImage:nil
                                shareToSnsNames:snsNames
                                       delegate:self];
}

#pragma mark - UMSocialUIDelegate

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

#pragma mark - WebView Delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (theTitle.length > 10) {
        theTitle = [[theTitle substringToIndex:9] stringByAppendingString:@"…"];
    }
    self.title = theTitle;
}

@end
