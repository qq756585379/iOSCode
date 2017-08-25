//
//  OpenALAudioPlay.m
//  AVMedia
//
//  Created by 杨俊 on 2017/8/25.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "OpenALAudioPlay.h"
#import <AVFoundation/AVFoundation.h>
#import <OpenAL/alc.h>
#import <OpenAL/al.h>

@interface OpenALAudioPlay()
@property(nonatomic)ALCcontext *mContext;
@property(nonatomic)ALCdevice  *mDevice;
@property(nonatomic,retain)NSMutableDictionary *soundDictionary;
@property(nonatomic,retain)NSMutableArray *bufferStorageArray;
@end

@implementation OpenALAudioPlay
{
    ALuint outSourceId;
    ALuint buff;
}

+(instancetype)sharePaly{
    static OpenALAudioPlay *sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [[OpenALAudioPlay alloc] init];
    });
    return sessionManager;
}

-(instancetype)init{
    if (self = [super init]) {
        [self initOpenAL];
    }
    return self;
}

-(void)initOpenAL{
    _mDevice = alcOpenDevice(NULL);
    if (_mDevice) {
        _mContext = alcCreateContext(_mDevice, NULL);
        alcMakeContextCurrent(_mContext);
    }
    
    alGenSources(1, &outSourceId);
    alSpeedOfSound(1.0);
    alDopplerVelocity(1.0);
    alDopplerFactor(1.0);
    alSourcef(outSourceId, AL_PITCH, 1.0f);
    alSourcef(outSourceId, AL_GAIN, 1.0f);
    alSourcei(outSourceId, AL_LOOPING, AL_FALSE);
    alSourcef(outSourceId, AL_SOURCE_TYPE, AL_STREAMING);
    //忽略静音键
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
}

-(void)openAudioFromQueue:(uint8_t *)data dataSize:(size_t)dataSize
               samplerate:(int)samplerate channels:(int)channels aBit:(int)bit{
    if (data == NULL) return;
    NSCondition *ticketCondition= [[NSCondition alloc] init];
    [ticketCondition lock];
    if (!_mContext) {
        [self initOpenAL];
    }
    ALuint bufferID = 0;
    alGenBuffers(1, &bufferID);
    ALenum format = 0;
    
    printf("-----samplerate:%d----channels:%d\n",samplerate,channels);
    
    if (bit == 8) {
        if (channels == 1)
            format = AL_FORMAT_MONO8;
        else if(channels == 2)
            format = AL_FORMAT_STEREO8;
        else if( alIsExtensionPresent( "AL_EXT_MCFORMATS" ) ){
            if( channels == 4 ){
                format = alGetEnumValue( "AL_FORMAT_QUAD8" );
            }
            if( channels == 6 ){
                format = alGetEnumValue( "AL_FORMAT_51CHN8" );
            }
        }
    }else if( bit == 16 ){
        if( channels == 1 ){
            format = AL_FORMAT_MONO16;
        }
        if( channels == 2 ){
            format = AL_FORMAT_STEREO16;
        }
        if( alIsExtensionPresent( "AL_EXT_MCFORMATS" ) ){
            if( channels == 4 ){
                format = alGetEnumValue( "AL_FORMAT_QUAD16" );
            }
            if( channels == 6 ){
                format = alGetEnumValue( "AL_FORMAT_51CHN16" );
            }
        }
    }
    
    ALenum error = AL_NO_ERROR;
    if((error = alGetError()) != AL_NO_ERROR) {
        NSLog(@"error alGenBuffers: %x\n", error);
    }else{
        NSData *tmpData = [NSData dataWithBytes:data length:dataSize];
        alBufferData(bufferID, format, (char *)[tmpData bytes], (ALsizei)[tmpData length],samplerate);
        if((error = alGetError()) != AL_NO_ERROR){
            NSLog(@"error sucalBufferData: %x\n", error);
        }else{
            alSourceQueueBuffers(outSourceId, 1, &bufferID);
            if((error = alGetError()) != AL_NO_ERROR){
                NSLog(@"error alSourceQueueBuffers: %x\n", error);
            }else{
                [self updataQueueBuffer];
            }
        }
    }
    
    [ticketCondition unlock];
    ticketCondition = nil;
}

- (BOOL)updataQueueBuffer{
    ALint stateVaue;
    int processed, queued;
    
    alGetSourcei(outSourceId, AL_BUFFERS_PROCESSED, &processed);
    alGetSourcei(outSourceId, AL_BUFFERS_QUEUED, &queued);
    alGetSourcei(outSourceId, AL_SOURCE_STATE, &stateVaue);
    
    if (stateVaue == AL_STOPPED || stateVaue == AL_PAUSED || stateVaue == AL_INITIAL){
        //        if (queued < processed || queued == 0 ||(queued == 1 && processed ==1)) {
        //            [self stopSound];
        //            [self cleanUpOpenAL];
        //        }
        [self playSound];
    }else if (stateVaue == AL_PLAYING && queued < 1){
        [self pauseSound];
    }else if(stateVaue == 4116){
        return NO;
    }
    
    while(processed--){
        alSourceUnqueueBuffers(outSourceId, 1, &buff);
        alDeleteBuffers(1, &buff);
    }
    return YES;
}

#pragma make - play/stop/clean function
-(void)playSound{
    ALint value;
    alGetSourcei(outSourceId,AL_SOURCE_STATE,&value);
    if (value != AL_PLAYING){
        alSourcePlay(outSourceId);
    }
}

-(void)stopSound{
    alSourcePause(outSourceId);
    alSourceStop(outSourceId);
    [self cleanUpOpenAL];
}

-(void)pauseSound{
    ALint state;
    alGetSourcei(outSourceId, AL_SOURCE_STATE, &state);
    if (state == AL_PLAYING){
        alSourcePause(outSourceId);
    }
}

-(void)cleanUpOpenAL{
    int processed;
    alGetSourcei(outSourceId, AL_BUFFERS_PROCESSED, &processed);
    while(processed--){
        //        alSourceUnqueueBuffers(outSourceId, 1, &buff);
        alDeleteBuffers(1, &buff);
    }
    //    alDeleteSources(1, &outSourceId);
    //    alDeleteBuffers(1, &buff);
    //    alcDestroyContext(mContext);
    //    alcCloseDevice(mDevicde);
    //    if (mContext != nil)
    //    {
    //        alcDestroyContext(mContext);
    //        mContext=nil;
    //    }
    //    if (mDevicde !=nil)
    //    {
    //        alcCloseDevice(mDevicde);
    //        mDevicde=nil;
    //    }
}

@end




