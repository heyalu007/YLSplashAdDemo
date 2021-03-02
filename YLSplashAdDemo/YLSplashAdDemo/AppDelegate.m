//
//  AppDelegate.m
//  YLSplashAdDemo
//
//  Created by 何亚鲁 on 2021/2/26.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "YLSpalshAdManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    UIViewController *vc = [[ViewController alloc] init];
    vc.view.frame = [UIScreen mainScreen].bounds;
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    
    [[YLSpalshAdManager sharedInstance] showSpalshAdViewInWindow:[UIApplication sharedApplication].delegate.window];
    
    return YES;
}


@end
