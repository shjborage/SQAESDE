//
//  SQSoundManager.m
//  iosplayer
//
//  Created by Shi Eric on 4/16/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import "SQSoundManager.h"

static SQSoundManager *g_sound;

@implementation SQSoundManager

- (void)dealloc
{
    [_audioPlayer release];
    
    [super dealloc];
}

+ (id)defaultManager
{
    if (g_sound == nil)
        g_sound = [[SQSoundManager alloc] init];
    
    return g_sound;
}

#pragma mark Audio session callbacks_______________________

// Audio session callback function for responding to audio route changes. If playing 
//		back application audio when the headset is unplugged, this callback pauses 
//		playback and displays an alert that allows the user to resume or stop playback.
//
//		The system takes care of iPod audio pausing during route changes--this callback  
//		is not involved with pausing playback of iPod audio.
void audioRouteChangeListenerCallback (
                                       void                      *inUserData,
                                       AudioSessionPropertyID    inPropertyID,
                                       UInt32                    inPropertyValueSize,
                                       const void                *inPropertyValue
                                       ) 
{
    
}	

#pragma mark - caf play

- (void)playCafFile:(NSString *)strCafPath volume:(CGFloat)fVolume
{    
	// Converts the sound's file path to an NSURL object
	NSURL *newURL = [[NSURL alloc] initFileURLWithPath:strCafPath];

	// Registers this class as the delegate of the audio session.
	[[AVAudioSession sharedInstance] setDelegate:self];
	
	// The AmbientSound category allows application audio to mix with Media Player
	// audio. The category also indicates that application audio should stop playing 
	// if the Ring/Siilent switch is set to "silent" or the screen locks.
    // Upper was describe the Category "AVAudioSessionCategoryAmbient", for play audio
    // in the backgroud, modify it to "AVAudioSessionCategoryPlayback" and add 
    // Required background modes in app info.plist for key "App plays audio".
	[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error: nil];

	// Registers the audio route change listener callback function
	AudioSessionAddPropertyListener (
                                     kAudioSessionProperty_AudioRouteChange,
                                     audioRouteChangeListenerCallback,
                                     self
                                     );
    
	// Activates the audio session.
	
	NSError *activationError = nil;
	[[AVAudioSession sharedInstance] setActive:YES error:&activationError];
    
    if (_audioPlayer != nil)
        [[_audioPlayer stop], _audioPlayer release];
    
	// Instantiates the AVAudioPlayer object, initializing it with the sound
	_audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:newURL error: nil];
	
	// "Preparing to play" attaches to the audio hardware and ensures that playback
	//		starts quickly when the user taps Play
	[_audioPlayer prepareToPlay];
    
    [_audioPlayer setVolume:fVolume];
    
	[_audioPlayer setDelegate:self];
    [_audioPlayer play];
    
    [newURL release];
}

- (void)stop
{
    if (_audioPlayer != nil)
        [_audioPlayer stop];
}

#pragma mark AV Foundation delegate methods____________

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)appSoundPlayer successfully:(BOOL)flag
{
    if (_audioPlayer != nil) {
        [_audioPlayer stop];
    }
}

- (void)audioPlayerBeginInterruption:player
{
	NSLog (@"Interrupted. The system has paused audio playback.");
	
    if (_audioPlayer != nil) {
        [_audioPlayer pause];
    }
}

- (void)audioPlayerEndInterruption:player
{
	NSLog (@"Interruption ended. Resuming audio playback.");
    
    if (_audioPlayer != nil) {
        [_audioPlayer prepareToPlay];
        [_audioPlayer play];
    }
	
	// Reactivates the audio session, whether or not audio was playing
	//		when the interruption arrived.
	[[AVAudioSession sharedInstance] setActive:YES error:nil];
}

@end
