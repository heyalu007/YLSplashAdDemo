//
//  YLSpalshAdManager.m
//  YLSplashAdDemo
//
//  Created by 何亚鲁 on 2021/2/26.
//

#import "YLSpalshAdManager.h"
#import "YLSplashAdView.h"

@interface YLSpalshAdManager ()

@property (nonatomic, strong) YLSplashAdView *splashAdView;

@property (nonatomic, strong) NSURLSession *urlSession;

@end

static NSString * const urlString = @"http://lf.snssdk.com/api/ad/v16/splash/preload/?sdk_version=006091&refresh_num=6&version_code=6.9.0&language=zh&display_density=750x1334&app_name=hotsoon&vid=D7AB87BB-5F11-446C-83EC-12D0D01C8AB5&device_id=37158653501&channel=local_test&mcc_mnc=46011&utm_media=demo&resolution=750*1334&aid=13&ab_version=154259,159573,151232,157647,158751,159676,158056,158956,155244,151126,128827,157001,156034,155246,134128,158532,159898,158525,152027,150473,125174,159071,158273,159871,150784,156262,157133,149048,151306,157721,157295,158104,151421,152955,31643,159362,159876,131207,145585,156142,152581,150352,151117&os=iOS&ab_feature=z1&ab_group=z1&access=WIFI&update_version_code=621&carrier=%E4%B8%AD%E5%9B%BD%E7%A7%BB%E5%8A%A8&openudid=85d19eeb40cd0676ef762d4d06dfafaab71529bc&idfv=D7AB87BB-5F11-446C-83EC-12D0D01C8AB5&ac=WIFI&mac_address=1&os_version=10.3&bh=0&device_platform=iphone&iid=13281664854&ab_client=a1,f2,f7,e1&device_type=iPhone%20Simulator&idfa=00000000-0000-0000-0000-000000000000";

@implementation YLSpalshAdManager

+ (instancetype)sharedInstance {
    static YLSpalshAdManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YLSpalshAdManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        [self __loadAdData];
    }
    return self;
}

- (void)__loadAdData {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    configuration.URLCache = nil;
    _urlSession = [NSURLSession sessionWithConfiguration:configuration];
    NSURL *url = [NSURL URLWithString:urlString];
    
    CFAbsoluteTime begin = CFAbsoluteTimeGetCurrent();
    __weak typeof(self) weakSelf = self;
    [[_urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && [response isKindOfClass:[NSHTTPURLResponse class]]) {
//            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
//            __strong typeof(weakSelf) self = weakSelf;
            CFAbsoluteTime duration = CFAbsoluteTimeGetCurrent() - begin;
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setValue:@(duration * 1000.f) forKey:@"durarion_ad_request_total_times"];
            if (data) {
                NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@", jsonObj);
//                [self parserResult:jsonObj error:error];
            }
        }
    }] resume];
}

- (void)showSpalshAdViewInWindow:(UIWindow *)window {
    NSUInteger showSpalshAdCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"ShowSpalshAdCount"];
    
    NSLog(@"%@", [NSString stringWithFormat:@"%@", @(showSpalshAdCount)]);
    
    _splashAdView = [[YLSplashAdView alloc] initWithFrame:[UIApplication sharedApplication].delegate.window.bounds];
    _splashAdView.imageName = [NSString stringWithFormat:@"WechatIMG%@", @(showSpalshAdCount%3)];
    [_splashAdView showInWindow:window];
    
    __weak typeof(self) weakSelf = self;
    _splashAdView.didClickSpalshAdViewCallback = ^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didClickSpalshAdView:)]) {
            [weakSelf.delegate didClickSpalshAdView:weakSelf.splashAdView];
            [weakSelf.splashAdView removeFromSuperview];
        }
    };
    
    showSpalshAdCount ++;
    [[NSUserDefaults standardUserDefaults] setInteger:showSpalshAdCount forKey:@"ShowSpalshAdCount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




@end
