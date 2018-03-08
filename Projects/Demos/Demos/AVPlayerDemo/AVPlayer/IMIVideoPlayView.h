//
//  IMIVideoPlayView.h
//  Demos
//
//  Created by Luosa on 2017/5/12.
//  Copyright © 2017年 Luosa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger, IMIVideoPlayerState) {
    IMIVideoPlayerStatePlaying = 0,
    IMIVedioPlayerStateFailed,
    IMIVideoPlayerStateBuffering,
    IMIVideoPlayerStatePaused,
    IMIVideoPlayerStateFinished,
    IMIVideoPlayerStateStopped,
    IMIVideoPlayerStateUnknown,
    IMIVideoPlayerStateReadyToPlay
};

@protocol IMIVideoPlayViewDelegate <NSObject>
-(void)IMIVideoPlayViewCallBackSildeValue:(float)value;
@end

@interface IMIVideoPlayView : UIView

//videoGravity设置屏幕填充模式
@property (nonatomic, assign) AVLayerVideoGravity videoGravity;
@property (nonatomic,   weak) id <IMIVideoPlayViewDelegate> delegate;
@property (nonatomic, assign) IMIVideoPlayerState playerState;
@property (nonatomic, strong) AVPlayerItem *playItem; //外部传入
@property (strong, nonatomic) UIImageView *backImageView; //背景图
@property (nonatomic, strong) AVPlayer *player; /* 播放器 */
@property (nonatomic, assign) BOOL mute;
@property (nonatomic, assign) BOOL hideReplayButton;

- (void)destroyPlayer;
- (void)handlePlayButtonAction;
- (void)pausedByManual:(BOOL)isManual;

@end







