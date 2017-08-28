//
//  OTSAudioPlayer.h
//  OneStore
//
//  Created by xuexiang on 13-6-21.
//  Copyright (c) 2013年 OneStore. All rights reserved.
//

@interface OTSAudioPlayer : NSObject

+ (void)playSoundWithFileName:(NSString *)aFileName
                   bundleName:(NSString *)aBundleName
                       ofType:(NSString *)ext
                     andAlert:(BOOL)alert;

@end
