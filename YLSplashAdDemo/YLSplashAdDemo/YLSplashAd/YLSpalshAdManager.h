//
//  YLSpalshAdManager.h
//  YLSplashAdDemo
//
//  Created by 何亚鲁 on 2021/2/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLSpalshAdManager : NSObject

+ (instancetype)sharedInstance;


- (void)showSpalshAdViewInWindow:(UIWindow *)window;

@end

NS_ASSUME_NONNULL_END
