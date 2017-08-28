//
//  OTSAudioPlayer.m
//  OneStore
//
//  Created by xuexiang on 13-6-21.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

#import "OTSAudioPlayer.h"
#import <AudioToolBox/AudioToolbox.h>
#import "OTSLog.h"

@implementation OTSAudioPlayer

+ (void)playSoundWithFileName:(NSString *)aFileName bundleName:(NSString *)aBundleName ofType:(NSString *)ext andAlert:(BOOL)alert{
    NSBundle *bundle = [NSBundle mainBundle];
    if (aBundleName.length) {
        bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:aBundleName withExtension:@"bundle"]];
    }
    
    if (!bundle) {
        OTSLogE(@"play sound cannot find bundle,%@",aBundleName);
        return ;
    }
    
    NSString *path = [bundle pathForResource:aFileName ofType:ext];
    
    if (!path) {
        OTSLogE(@"play sound cannot find file [%@] in bundle [%@]",aFileName ,aBundleName);
        return ;
    }
    
    NSURL *urlFile = [NSURL fileURLWithPath:path];
    
    // 声明需要播放的音频文件ID[unsigned long]
    SystemSoundID ID;
    
    // 创建系统声音，同时返回一个ID
    OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)urlFile, &ID);
    
    if (err) {
        OTSLogE(@"play sound cannot create file url [%@]",urlFile);
        return ;
    }
    
    // 根据ID播放自定义系统声音
    if (alert) {
        AudioServicesPlayAlertSound(ID);
    }else {
        AudioServicesPlaySystemSound(ID);
    }
}

@end
