//
//  IMIVideoPlayView.m
//  Demos
//
//  Created by Luosa on 2017/5/12.
//  Copyright © 2017年 Luosa. All rights reserved.
//

#import "IMIVideoPlayView.h"
#import "Masonry.h"
#import "IMILog.h"
#import "UIImage+IMIUtil.h"
#import "NSBundle+imi.h"
#import "IMIMacro.h"
#import "NSObject+imiNotifi.h"
#import <PureLayout/PureLayout.h>

static NSString * const IMIRateKeyPath                      = @"rate";
static NSString * const IMIStatusKeyPath                    = @"status";
static NSString * const IMILoadedTimeRangesKeyPath          = @"loadedTimeRanges";
static NSString * const IMIPlaybackBufferEmptyKeyPath       = @"playbackBufferEmpty";
static NSString * const IMIPlaybackLikelyToKeepUpKeyPath    = @"playbackLikelyToKeepUp";

@interface IMIVideoPlayView()
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UIButton *replayButton;
@property (nonatomic, assign) BOOL isManualPaused;
@property (nonatomic, assign) CMTime time;
@end

@implementation IMIVideoPlayView
{
    id playbackTimerObserver;
}

// default is [CALayer class]. Used when creating the underlying layer for the view.
+(Class)layerClass{
    return [AVPlayerLayer class];
}
-(AVPlayerLayer *)playerLayer{
    return (AVPlayerLayer *)self.layer;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self p_init];
    }
    return self;
}

-(void)p_init{
    self.backImageView = [UIImageView newAutoLayoutView];
    self.backImageView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.backImageView];
    [self.backImageView autoPinEdgesToSuperviewEdges];
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self addSubview:self.indicatorView];
    [self.indicatorView autoCenterInSuperview];
    
    self.replayButton = [UIButton newAutoLayoutView];
    if (!self.hideReplayButton) {
        [self.replayButton setImage:[UIImage imageNamed:@"IMI003_replay.png"] forState:UIControlStateNormal];
        [self.replayButton addTarget:self action:@selector(replayAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.replayButton];
        [self.replayButton autoCenterInSuperview];
        self.replayButton.hidden = YES;
    }
    
    //默认值
    self.playItem		 = nil;
    self.isManualPaused  = YES;
    self.playerState     = IMIVideoPlayerStateUnknown;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    self.player = [[AVPlayer alloc] init];
    self.playerLayer.player = self.player;
    [self.player addObserver:self forKeyPath:IMIRateKeyPath options:NSKeyValueObservingOptionNew context:nil];
    IMI_WEAK_SELF
    playbackTimerObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.f, 1.f) queue:NULL usingBlock:^(CMTime time){
        IMI_STRONG_SELF
        if (self.delegate && [self.delegate respondsToSelector:@selector(IMIVideoPlayViewCallBackSildeValue:)]) {
            if (self.playItem == nil) return;
            float value = self.playItem.currentTime.value / self.playItem.currentTime.timescale;
            [self.delegate IMIVideoPlayViewCallBackSildeValue:value];
        }
    }];
    
    [self observeNotification:UIApplicationWillEnterForegroundNotification];
    [self observeNotification:UIApplicationDidEnterBackgroundNotification];
}

- (void)handleNotification:(NSNotification *)notification{
    if ([notification.name isEqualToString:UIApplicationDidEnterBackgroundNotification]) {
        if (self.playItem == nil) return;
        [self.player pause];
        self.time = self.player.currentTime;
    }else if ([notification.name isEqualToString:UIApplicationWillEnterForegroundNotification]){
        if (self.playItem == nil) return;
        if (self.playerState == IMIVideoPlayerStateFinished) return;
        
        if (!_isManualPaused) {
            if (CMTimeGetSeconds(self.time) > 0.f) {
                @try {
                    [self.player seekToTime:self.time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
                        if (finished) {
                            [self.player play];
                        }
                    }];
                } @catch (NSException *exception) {
                    [self.player play];
                }
                self.playerState = IMIVideoPlayerStatePlaying;
            }
        }
    }
}

-(void)setPlayItem:(AVPlayerItem *)playItem{
    [self removePlayItemKVOAndNotifi];
    _playItem = playItem;
    [self addPlayItemKVOAndNotifi];
    [self.player replaceCurrentItemWithPlayerItem:playItem];
    [self.player pause];
    self.playerState = IMIVideoPlayerStateReadyToPlay;
}

-(void)setMute:(BOOL)mute{
    _mute = mute;
    self.player.muted = mute;
}

-(void)setVideoGravity:(AVLayerVideoGravity)videoGravity{
    _videoGravity = videoGravity;
    self.playerLayer.videoGravity = videoGravity;
}

- (void)pausedByManual:(BOOL)isManual{
    self.isManualPaused = isManual;
    self.playerState = IMIVideoPlayerStatePaused;
    [self.player pause];
}

- (void)handlePlayButtonAction{
    if (self.playItem == nil) return;
    self.replayButton.hidden = YES;
    if (self.playerState != IMIVideoPlayerStatePlaying) {
        [self.player play];
        self.mute = _mute ? YES : NO;
        self.playerState = IMIVideoPlayerStatePlaying;
        self.isManualPaused = NO;
    }else{
        self.isManualPaused = YES;
        self.playerState = IMIVideoPlayerStatePaused;
        [self.player pause];
    }
}

- (void)replayAction {
    self.replayButton.hidden = YES;
    self.playerState = IMIVideoPlayerStatePlaying;
    [self.player play];
}

#pragma mark - 通知
- (void)moviePlayDidEnd:(NSNotification *)notification {
    [self.playItem seekToTime:kCMTimeZero];
    [self.player pause];
    self.replayButton.hidden = NO;
    self.playerState = IMIVideoPlayerStateFinished;
}

#pragma mark - 观察者对应的方法
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    //AVPlayerItemStatus itemStatus = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
    if ([keyPath isEqualToString:IMIStatusKeyPath]) {
        AVPlayerItem *playerItem = (AVPlayerItem *)object;
        switch (playerItem.status) {
            case AVPlayerStatusReadyToPlay:{
                IMIDLog(@"AVPlayerStatusReadyToPlay");
                self.playerState = IMIVideoPlayerStateReadyToPlay;
                [self.indicatorView stopAnimating];
                self.backImageView.hidden = YES;
                self.replayButton.hidden = YES;
                break;
            }
            case AVPlayerStatusFailed:{
                self.playerState = IMIVedioPlayerStateFailed;
                [self.indicatorView stopAnimating];
                break;
            }
            case AVPlayerStatusUnknown:{
                IMIDLog(@"AVPlayerStatusUnknown");
                self.playerState = IMIVideoPlayerStateUnknown;
                [self.indicatorView stopAnimating];
                self.replayButton.hidden = YES;
                break;
            }
        }
    }
    
    if ([keyPath isEqualToString:IMILoadedTimeRangesKeyPath]) { //监听播放器的下载进度
        self.replayButton.hidden = YES;
        AVPlayerItem *playerItem = (AVPlayerItem *)object;
        NSArray *loadedTimeRanges = [playerItem loadedTimeRanges];
        CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];//获取缓冲区域
        float bufferStart = CMTimeGetSeconds(timeRange.start);
        float bufferDuration = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval bufferProgress = bufferStart + bufferDuration;// 计算缓冲总进度
        CMTime duration = playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        //[self.videoCacheProgress setProgress:bufferProgress / totalDuration animated:YES];
        NSLog(@"SRVideoPlayerItemLoadedTimeRangesKeyPath-------缓冲%f",bufferProgress / totalDuration);
    }
    
    if ([keyPath isEqualToString:IMIPlaybackBufferEmptyKeyPath]) {
        NSLog(@"SRVideoPlayerItemPlaybackBufferEmptyKeyPath");
        self.playerState = IMIVideoPlayerStateBuffering;
        [self.indicatorView startAnimating];
        self.replayButton.hidden = YES;
    }
    
    if ([keyPath isEqualToString:IMIPlaybackLikelyToKeepUpKeyPath]) { //缓冲达到可播放
        [self.indicatorView stopAnimating];
        self.replayButton.hidden = YES;
    }
    
    if ([keyPath isEqualToString:IMIRateKeyPath]){//当rate==0时为暂停,rate==1时为播放,当rate等于负数时为回放
        self.replayButton.hidden = YES;
        if ([[change objectForKey:NSKeyValueChangeNewKey] integerValue]==0) {
            self.playerState = IMIVideoPlayerStatePaused;
        }else{
            self.playerState = IMIVideoPlayerStatePlaying;
            [self.indicatorView stopAnimating];
        }
    }
}

- (void)destroyPlayer{
    if (self.playItem) {
        [self.playItem cancelPendingSeeks];
        [self.playItem.asset cancelLoading];
        [self removePlayItemKVOAndNotifi];
        _playItem = nil;
    }
    if (self.player) {
        [self.player pause];
        [self.player cancelPendingPrerolls];
        [self.player replaceCurrentItemWithPlayerItem:nil];
        [self.player removeObserver:self forKeyPath:IMIRateKeyPath];
        [self.player removeTimeObserver:playbackTimerObserver];
        self.player = nil;
    }
    [self removeFromSuperview];
}

-(void)addPlayItemKVOAndNotifi{
    [self.playItem addObserver:self forKeyPath:IMIStatusKeyPath options:NSKeyValueObservingOptionNew context:nil];
    //监听网络加载情况属性
    [self.playItem addObserver:self forKeyPath:IMILoadedTimeRangesKeyPath options:NSKeyValueObservingOptionNew context:nil];
    //监听播放的区域缓存是否为空
    [self.playItem addObserver:self forKeyPath:IMIPlaybackBufferEmptyKeyPath
                       options:NSKeyValueObservingOptionNew context:nil];
    //缓存可以播放的时候调用
    [self.playItem addObserver:self forKeyPath:IMIPlaybackLikelyToKeepUpKeyPath
                       options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayDidEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.playItem];
}

-(void)removePlayItemKVOAndNotifi{
    if (self.playItem == nil) return;
    [self.playItem removeObserver:self forKeyPath:IMIStatusKeyPath];
    [self.playItem removeObserver:self forKeyPath:IMILoadedTimeRangesKeyPath];
    [self.playItem removeObserver:self forKeyPath:IMIPlaybackBufferEmptyKeyPath];
    [self.playItem removeObserver:self forKeyPath:IMIPlaybackLikelyToKeepUpKeyPath];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:self.playItem];
}

- (void)dealloc{
    [self destroyPlayer];
    [self unobserveAllNotifications];
}

@end


//videoGravity设置屏幕填充模式
//-(NSString *)getVideoGravityMode{
//    switch (self.mode) {
//        case IMILayerVideoGravityResizeAspect:
//            return AVLayerVideoGravityResizeAspect;
//            break;
//        case IMILayerVideoGravityResizeAspectFill:
//            return AVLayerVideoGravityResizeAspectFill;
//            break;
//        case IMILayerVideoGravityResize:
//            return AVLayerVideoGravityResize;
//            break;
//        default:
//            return AVLayerVideoGravityResizeAspect;
//            break;
//    }
//}
//-(void)addGestureRecognizer{
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//    tapGesture.numberOfTapsRequired = 1; //点击次数
//    tapGesture.numberOfTouchesRequired = 1; //点击手指数
//    [self.backImageView addGestureRecognizer:tapGesture];
//
//    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
//    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//    [self.backImageView addGestureRecognizer:swipeLeft];
//    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
//    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
//    [self.backImageView addGestureRecognizer:swipeRight];
//}
#pragma mark - 手势
//-(void)tap:(UITapGestureRecognizer *)sender {
//
//}
//- (void)swipe:(UISwipeGestureRecognizer *)sender {
//    if (sender.direction == UISwipeGestureRecognizerDirectionRight){
//        [self swipeToRight:YES];
//    }else if (sender.direction == UISwipeGestureRecognizerDirectionLeft){
//        [self swipeToRight:NO];
//    }
//}
//- (void)swipeToRight:(BOOL)isRight{
//    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.currentTime);
//    if (isRight) {
//        currentTime += 10;
//    } else {
//        currentTime -= 10;
//    }
//    if (currentTime >= CMTimeGetSeconds(self.player.currentItem.duration)) {
//        currentTime = CMTimeGetSeconds(self.player.currentItem.duration) - 1;
//    } else if (currentTime <= 0) {
//        currentTime = 0;
//    }
//    [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
//    [self updateProgressInfo];
//}

//- (void)seekToTimeWithSeconds:(CGFloat)seconds {
//    CMTime duration = _currentItem.duration;
//    CGFloat totalDuration = CMTimeGetSeconds(duration);
//    seconds = MAX(0, seconds);
//    seconds = MIN(seconds, totalDuration);
//    [self.player pause];
//    IMI_WEAK_SELF
//    [self.player seekToTime:CMTimeMakeWithSeconds(seconds, NSEC_PER_SEC) completionHandler:^(BOOL finished) {
//        IMI_STRONG_SELF
//        [self.player play];
//        self.isManualPaused = NO;
//        self.playerState = IMIVideoPlayerStatePlaying;
//    }];
//}

//- (void)seekToTimeWithSeconds:(CGFloat)seconds {
//    CMTime duration = _currentItem.duration;
//    CGFloat totalDuration = CMTimeGetSeconds(duration);
//    seconds = MAX(0, seconds);
//    seconds = MIN(seconds, totalDuration);
//    [self.player pause];
//    IMI_WEAK_SELF
//    [self.player seekToTime:CMTimeMakeWithSeconds(seconds, NSEC_PER_SEC) completionHandler:^(BOOL finished) {
//        IMI_STRONG_SELF
//        [self.player play];
//        self.isManualPaused = NO;
//        self.playerState = IMIVideoPlayerStatePlaying;
//        if (!self.currentItem.isPlaybackLikelyToKeepUp) {
//            self.playerState = IMIVideoPlayerStateBuffering;
//            [self.activityIndicatorView startAnimating];
//        }
//    }];
//}
#pragma mark - slider事件
//- (IBAction)sliderValueChange:(UISlider *)sender {
//    if (!_currentItem) return;
//    [self.player pause];
//    [self removeProgressTimer];
//    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * self.processSilder.value;
//    self.leftTimeLabel.text = [self formatTimeWith:currentTime];
//}
//- (IBAction)sliderDidEndChange:(UISlider *)sender {
//    if (!_currentItem) return;
//    CMTime pointTime = CMTimeMake(self.processSilder.value * self.currentItem.currentTime.timescale,
//                                  self.currentItem.currentTime.timescale);
//    [self.currentItem seekToTime:pointTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
//
//    CMTime duration = _currentItem.duration;
//    CGFloat totalDuration = CMTimeGetSeconds(duration);
//
//    if (self.playerState == IMIVideoPlayerStatePlaying) {
//        [self seekToTimeWithSeconds:sender.value * totalDuration];
//        [self addProgressTimer];
//    }else{
//        [self pause];
//    }
//}



