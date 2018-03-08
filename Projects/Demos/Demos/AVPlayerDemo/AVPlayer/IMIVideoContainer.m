//
//  IMIVideoContainer.m
//  MiHome
//
//  Created by 杨俊 on 2017/9/14.
//  Copyright © 2017年 小米移动软件. All rights reserved.
//

#import "IMIVideoContainer.h"
#import "IMIPlayerBottomBar.h"
#import "UIView+IMIUtil.h"
#import "UIImage+IMIUtil.h"
#import "IMIMacro.h"
#import "NSObject+imiPerformBlock.h"
#import "NSString+imi.h"
#import <PureLayout/PureLayout.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface IMIVideoContainer()<IMIVideoPlayViewDelegate>
@property (nonatomic, strong) IMIPlayerBottomBar *vedioBottomBar;
@property (nonatomic, strong) IMIVideoPlayView *vedioPlayerView;
@end

@implementation IMIVideoContainer

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self p_buildup];
    }
    return self;
}

-(void)p_buildup{
    self.backgroundColor = [UIColor blackColor];
    
    self.vedioPlayerView = [IMIVideoPlayView newAutoLayoutView];
    self.vedioPlayerView.delegate = self;
    [self addSubview:self.vedioPlayerView];
    
    [self addSubview:self.vedioBottomBar];
    [self.vedioPlayerView autoPinEdgesToSuperviewEdges];
    [self.vedioBottomBar autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.vedioBottomBar autoSetDimension:ALDimensionHeight toSize:44];
    
    @weakify(self);
    [RACObserve(self.vedioPlayerView, playerState) subscribeNext:^(id x) {
        @strongify(self);
        if ([x intValue] == IMIVideoPlayerStatePlaying) {
            self.vedioBottomBar.playOrPauseBtn.selected = YES;
        } else if ([x intValue] == IMIVideoPlayerStatePaused) {
            self.vedioBottomBar.playOrPauseBtn.selected = NO;
        }
        self.vedioPlayerView.backImageView.hidden = YES;
    }];
}

-(void)setVideoURL:(NSURL *)videoURL{
    if (!videoURL) return;
    _videoURL = videoURL;
    //YES，duration需要返回一个精确值，计算量会比较大，耗时比较长
    NSDictionary *options = @{ AVURLAssetPreferPreciseDurationAndTimingKey : @YES };
    self.avasset = [[AVURLAsset alloc] initWithURL:videoURL options:options];
}

-(void)setAvasset:(AVURLAsset *)avasset{
    _avasset = avasset;
    IMI_WEAK_SELF
    [_avasset loadValuesAsynchronouslyForKeys:@[@"duration"] completionHandler:^{//异步加载属性
        IMI_STRONG_SELF
        NSError *error = nil;
        AVKeyValueStatus tracksStatus = [self.avasset statusOfValueForKey:@"duration" error:&error];
        switch (tracksStatus) {
            case AVKeyValueStatusLoaded:{
                NSLog(@"AVKeyValueStatusLoaded");
                [self.avasset cancelLoading];
                [self preparePlay];
            }
                break;
            case AVKeyValueStatusFailed:{
                NSLog(@"AVKeyValueStatusFailed取消");
            }
                break;
            case AVKeyValueStatusCancelled:{
                NSLog(@"AVKeyValueStatusCancelled取消");
            }
                break;
            case AVKeyValueStatusUnknown:{
                NSLog(@"AVKeyValueStatusUnknown未知");
            }
                break;
            case AVKeyValueStatusLoading:{
                NSLog(@"AVKeyValueStatusLoading正在加载");
            }
                break;
            default:
                break;
        }
    }];
}

-(void)preparePlay{
    [self performInMainThreadBlock:^{
        self.vedioBottomBar.leftLabel.text  = @"00:00";
        self.vedioBottomBar.rightLabel.text = @"00:00";
        if (CMTIME_IS_INDEFINITE(self.avasset.duration)) {
            return;
        }
        CGFloat second = self.avasset.duration.value / self.avasset.duration.timescale;
        self.vedioBottomBar.rightLabel.text = [NSString MM_SS_timeFormattedFromSeconds:second];
        self.vedioBottomBar.silder.minimumValue = 0;
        self.vedioBottomBar.silder.maximumValue = second;
        AVPlayerItem *currentItem = [AVPlayerItem playerItemWithAsset:self.avasset];
        self.vedioPlayerView.playItem = currentItem;
        if (self.playImmediately) {
            [self.vedioPlayerView.player play];
        }
    }];
}

-(BOOL)isIsPlaying{
    return self.vedioPlayerView.playerState == IMIVideoPlayerStatePlaying ||
           self.vedioPlayerView.playerState == IMIVideoPlayerStateBuffering;
}

-(void)destroyPlayer{
    [self.vedioPlayerView destroyPlayer];
}
-(void)pausedByManual:(BOOL)isManual{
    [self.vedioPlayerView pausedByManual:isManual];
}
-(void)showPlaceHoldImage:(UIImage *)image{
    if (image) {
        self.vedioPlayerView.backImageView.image = image;
        self.vedioPlayerView.backImageView.hidden = NO;
    }else{
        self.vedioPlayerView.backImageView.hidden = YES;
    }
}
-(void)playOrPauseAction:(UIButton *)sender{
    [self.vedioPlayerView handlePlayButtonAction];
    if (self.imi_callBackBlock) {
        self.imi_callBackBlock(nil);
    }
}
-(void)voiceAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.vedioPlayerView.mute = sender.selected;
}

-(void)switchOrientation:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) { //切换到大屏
        [self removeFromSuperview];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self autoCenterInSuperview];
        [self autoSetDimensionsToSize:CGSizeMake(IMILandscapeVideoWidth, kIMIScreenWidth)];
        [UIView animateWithDuration:0.5 animations:^{
            [UIApplication sharedApplication].statusBarHidden = YES;
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
        }];
    } else {
        [self removeFromSuperview];
        [self.playerSuperView addSubview:self];
        [self autoPinEdgesToSuperviewEdges];
        [UIView animateWithDuration:0.5 animations:^{
            [UIApplication sharedApplication].statusBarHidden = NO;
            self.transform = CGAffineTransformIdentity;
        }];
    }
}

#pragma mark - IMIVideoPlayViewDelegate
-(void)IMIVideoPlayViewCallBackSildeValue:(float)value{
    self.vedioBottomBar.silder.value = value;
    self.vedioBottomBar.leftLabel.text = [NSString MM_SS_timeFormattedFromSeconds:value];
}

-(IMIPlayerBottomBar *)vedioBottomBar{
    if (!_vedioBottomBar) {
        _vedioBottomBar = [IMIPlayerBottomBar viewFromXib];
        _vedioBottomBar.voiceBtn.selected = YES;
        [_vedioBottomBar.playOrPauseBtn addTarget:self action:@selector(playOrPauseAction:)
                                 forControlEvents:UIControlEventTouchUpInside];
        [_vedioBottomBar.voiceBtn addTarget:self action:@selector(voiceAction:) forControlEvents:UIControlEventTouchUpInside];
        [_vedioBottomBar.fullScreenBtn addTarget:self action:@selector(switchOrientation:) forControlEvents:UIControlEventTouchUpInside];
        [_vedioBottomBar.silder setThumbImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    }
    return _vedioBottomBar;
}

@end
