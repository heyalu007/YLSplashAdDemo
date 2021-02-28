//
//  YLSpalshAdManager.m
//  YLSplashAdDemo
//
//  Created by 何亚鲁 on 2021/2/26.
//

#import "YLSpalshAdManager.h"
#import "YLSplashAdView.h"

@implementation YLSpalshAdManager

+ (instancetype)sharedInstance {
    static YLSpalshAdManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YLSpalshAdManager alloc] init];
    });
    return instance;
}

- (void)showSpalshAdViewInWindow:(UIWindow *)window {
    NSUInteger showSpalshAdCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"ShowSpalshAdCount"];
    
    NSLog(@"%@", [NSString stringWithFormat:@"%@", @(showSpalshAdCount)]);
    
    YLSplashAdView *splashAdView = [[YLSplashAdView alloc] initWithFrame:[UIApplication sharedApplication].delegate.window.bounds];
    splashAdView.imageName = [NSString stringWithFormat:@"%@", @(showSpalshAdCount%2)];
    [splashAdView showInWindow:window];
    
    showSpalshAdCount ++;
    [[NSUserDefaults standardUserDefaults] setInteger:showSpalshAdCount forKey:@"ShowSpalshAdCount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"%@", [NSString stringWithFormat:@"%@", @(showSpalshAdCount)]);
}



@end
