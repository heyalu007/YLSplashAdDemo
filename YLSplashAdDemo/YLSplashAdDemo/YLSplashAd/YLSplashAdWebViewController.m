//
//  YLSplashAdWebViewController.m
//  YLSplashAdDemo
//
//  Created by 何亚鲁 on 2021/3/1.
//

#import "YLSplashAdWebViewController.h"
#import <WebKit/WebKit.h>

@interface YLSplashAdWebViewController ()

@property (nonatomic, copy) NSString *adUrl;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation YLSplashAdWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"点击进入广告链接";
    self.view.backgroundColor = [UIColor whiteColor];
    

    WKWebViewConfiguration *webConfiguration = [WKWebViewConfiguration new];
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:webConfiguration];
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    
    NSString *urlStr = @"https://www.douyin.com";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
}


@end
