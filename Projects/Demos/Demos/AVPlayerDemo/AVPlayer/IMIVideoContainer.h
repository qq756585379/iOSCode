//
//  IMIVideoContainer.h
//  MiHome
//
//  Created by 杨俊 on 2017/9/14.
//  Copyright © 2017年 小米移动软件. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMIVideoPlayView.h"
#import <AVFoundation/AVFoundation.h>

@interface IMIVideoContainer : UIView

@property (nonatomic,   weak) UIView *playerSuperView;

@property (nonatomic, strong) NSURL *videoURL;

@property (nonatomic, strong) AVURLAsset *avasset;

@property (nonatomic, assign) BOOL playImmediately;

@property (nonatomic, assign) BOOL isPlaying;

-(void)showPlaceHoldImage:(UIImage *)image;

-(void)pausedByManual:(BOOL)isManual;

-(void)destroyPlayer;

@end
