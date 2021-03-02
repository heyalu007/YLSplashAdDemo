
#import "YLSplashAdView.h"

@interface YLSplashAdView ()

@property (nonatomic, strong) UIImageView *adView;

@property (nonatomic, strong) UIButton *countBtn;

@property (nonatomic, strong) NSTimer *countTimer;

@property (nonatomic, assign) int count;

@end

// 广告显示的时间

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

static int const kShowTime = 3;


@implementation YLSplashAdView

- (NSTimer *)countTimer {
    
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // 1.广告图片
        _adView = [[UIImageView alloc] initWithFrame:frame];
        _adView.userInteractionEnabled = YES;
        _adView.contentMode = UIViewContentModeScaleAspectFill;
        _adView.clipsToBounds = YES;
//        _adView.image = [UIImage imageNamed:@"LaunchImage_667h"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickSpalshAdView)];
        [_adView addGestureRecognizer:tap];
        
        [self addSubview:_adView];
        
        // 2.跳过按钮
        CGFloat btnW = 60;
        CGFloat btnH = 30;
        _countBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - btnW - 24, 60, btnW, btnH)];
        [_countBtn addTarget:self action:@selector(removeAdvertView) forControlEvents:UIControlEventTouchUpInside];
        [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d", kShowTime] forState:UIControlStateNormal];
        _countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countBtn.backgroundColor = [UIColor colorWithRed:20 /255.0 green:20 /255.0 blue:20 /255.0 alpha:0.8];
        _countBtn.layer.cornerRadius = 4;

        [self addSubview:_countBtn];
        
    }
    return self;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    _adView.image = [UIImage imageNamed:imageName];
}

- (void)didClickSpalshAdView {
    [self.countTimer invalidate];
    self.countTimer = nil;
    
    if (self.didClickSpalshAdViewCallback) {
        self.didClickSpalshAdViewCallback();
    }
}

- (void)countDown {
    
    _count --;
    [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",_count] forState:UIControlStateNormal];
    if (_count == 0) {
        [self removeAdvertView];
    }
}


- (void)showInWindow:(UIWindow *)window {
    [self startTimer];
    [window addSubview:self];
}

// 定时器倒计时
- (void)startTimer {
    _count = kShowTime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}

// GCD倒计时
- (void)startCoundown {
    
    __weak __typeof(self) weakSelf = self;
    __block int timeout = kShowTime + 1; //倒计时时间 + 1
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf removeAdvertView];
            });
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.countBtn setTitle:[NSString stringWithFormat:@"跳过%d",timeout] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

// 移除广告页面
- (void)removeAdvertView {
    
    // 停掉定时器
    [self.countTimer invalidate];
    self.countTimer = nil;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}

@end
