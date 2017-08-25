//
//  OpenALAudioPlay.h
//  AVMedia
//
//  Created by 杨俊 on 2017/8/25.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenALAudioPlay : NSObject

+(instancetype)sharePaly;

-(void)openAudioFromQueue:(uint8_t *)data dataSize:(size_t)dataSize
               samplerate:(int)samplerate channels:(int)channels aBit:(int)bit;
-(void)stopSound;

@end
