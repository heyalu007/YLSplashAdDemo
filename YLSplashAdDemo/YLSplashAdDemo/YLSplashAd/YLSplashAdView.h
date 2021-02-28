
#import <UIKit/UIKit.h>


@interface YLSplashAdView : UIView

/**
*  显示广告页面方法
*/
- (void)showInWindow:(UIWindow *)window;

/**
 *  图片路径
 */
@property (nonatomic, copy) NSString *filePath;

@property (nonatomic, copy) NSString *imageName;


@end
