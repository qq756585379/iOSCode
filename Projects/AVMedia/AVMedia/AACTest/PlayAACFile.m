//
//  PlayAACFile.m
//  AVMedia
//
//  Created by 杨俊 on 2017/8/25.
//  Copyright © 2017年 Lenovo-Apple. All rights reserved.
//

#import "PlayAACFile.h"
#include "neaacdec.h"
#import "OpenALAudioPlay.h"

#define FRAME_MAX_LEN  1024*5
#define BUFFER_MAX_LEN 1024*1024

@implementation PlayAACFile

void show_usage(){
    printf("usage\nfaaddec src_file dst_file");
}

-(int)startPlayAudio:(NSString *)path{
    static unsigned char frame[FRAME_MAX_LEN];
    static unsigned char buffer[BUFFER_MAX_LEN] = {0};
    
    FILE *ifile = NULL;
    unsigned long samplerate;
    unsigned char channels;
    
    NeAACDecHandle decoder = 0;
    size_t data_size = 0;
    size_t size = 0;
    
    NeAACDecFrameInfo frame_info;
    unsigned char *input_data = buffer;
    unsigned char *pcm_data = NULL;
    
    OpenALAudioPlay *audioPlay = [OpenALAudioPlay sharePaly];
    ifile = fopen([path UTF8String], "rb");
    if(!ifile){
        printf("source or destination file");
        return -1;
    }
    data_size = fread(buffer, 1, BUFFER_MAX_LEN, ifile);
    
    //open decoder
    decoder = NeAACDecOpen();
    if(get_one_ADTS_frame(buffer, data_size, frame, &size) < 0){
        return -1;
    }
    
    //initialize decoder
    NeAACDecInit(decoder, frame, size, &samplerate, &channels);
    printf("samplerate %lu, channels %d\n", samplerate, channels);
    
    while(get_one_ADTS_frame(input_data, data_size, frame, &size) == 0){
        printf("frame size %zu\n", size);
        
        // decode ADTS frame
        pcm_data = (unsigned char*)NeAACDecDecode(decoder, &frame_info, frame, size);
        
        if(frame_info.error > 0){
            printf("%s\n",NeAACDecGetErrorMessage(frame_info.error));
        }else if(pcm_data && frame_info.samples > 0){
            
            printf("frame info: bytesconsumed %lu, channels %d, header_type %d\
                   object_type %d, samples %lu, samplerate %lu\n",
                   frame_info.bytesconsumed,
                   frame_info.channels, frame_info.header_type,
                   frame_info.object_type, frame_info.samples,
                   frame_info.samplerate);
            
            [audioPlay openAudioFromQueue:pcm_data dataSize:(frame_info.samples * frame_info.channels) samplerate:(int)frame_info.samplerate channels:frame_info.channels aBit:16];
            /*
             pcm_data 为解码后的数据
             (frame_info.samples * frame_info.channels)  为解码后的数据大小
             */
        }
        data_size -= size;
        input_data += size;
    }
    
    [audioPlay stopSound];
    NeAACDecClose(decoder);
    fclose(ifile);
    return 0;
}

/**
 * fetch one ADTS frame
 */
int get_one_ADTS_frame(unsigned char* buffer, size_t buf_size, unsigned char* data ,size_t* data_size){
    size_t size = 0;
    if(!buffer || !data || !data_size ){
        return -1;
    }
    while(1){
        if(buf_size  < 7 ){
            return -1;
        }
        if((buffer[0] == 0xff) && ((buffer[1] & 0xf0) == 0xf0) ){
            size |= ((buffer[3] & 0x03) <<11);     //high 2 bit
            size |= buffer[4]<<3;                //middle 8 bit
            size |= ((buffer[5] & 0xe0)>>5);        //low 3bit
            break;
        }
        --buf_size;
        ++buffer;
    }
    if(buf_size < size){
        return -1;
    }
    memcpy(data, buffer, size);
    *data_size = size;
    return 0;
}

@end









