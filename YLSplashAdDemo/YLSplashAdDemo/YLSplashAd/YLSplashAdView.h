
#import <UIKit/UIKit.h>

typedef void(^DidClickSpalshAdViewCallback)(void);

@interface YLSplashAdView : UIView

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) DidClickSpalshAdViewCallback didClickSpalshAdViewCallback;

- (void)showInWindow:(UIWindow *)window;


@end
