//
//  YLSpalshAdManager.h
//  YLSplashAdDemo
//
//  Created by 何亚鲁 on 2021/2/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YLSplashAdView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YLSpalshAdDelegate <NSObject>

- (void)didClickSpalshAdView:(YLSplashAdView *)spalshAdView;

@end


@interface YLSpalshAdManager : NSObject

@property (nonatomic, weak) id<YLSpalshAdDelegate> delegate;

+ (instancetype)sharedInstance;

- (void)showSpalshAdViewInWindow:(UIWindow *)window;

@end

NS_ASSUME_NONNULL_END
