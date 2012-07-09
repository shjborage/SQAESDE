//
//  SQSoundManager.h
//  iosplayer
//
//  Created by Shi Eric on 4/16/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SQSoundManager : NSObject
<
AVAudioPlayerDelegate
>
{
    AVAudioPlayer *_audioPlayer;
}

+ (id)defaultManager;

/*
 * fVolume:The volume for the sound. The nominal range is from 0.0 to 1.0.
 */
- (void)playCafFile:(NSString *)strCafPath volume:(CGFloat)fVolume;
- (void)stop;

@end
