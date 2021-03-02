//
//  ViewController.m
//  YLSplashAdDemo
//
//  Created by 何亚鲁 on 2021/2/26.
//

#import "ViewController.h"
#import "YLSpalshAdManager.h"
#import "YLSplashAdWebViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController () <YLSpalshAdDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor purpleColor];
    [YLSpalshAdManager sharedInstance].delegate = self;
    
    
    
    WKWebViewConfiguration *webConfiguration = [WKWebViewConfiguration new];
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:webConfiguration];
    _webView.backgroundColor = [UIColor yellowColor];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];

    NSString *urlStr = @"https://www.baidu.com";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
}


- (void)didClickSpalshAdView:(nonnull YLSplashAdView *)spalshAdView {
    YLSplashAdWebViewController *webVC = [[YLSplashAdWebViewController alloc] init];
    [self presentViewController:webVC animated:YES completion:nil];
}

@end
