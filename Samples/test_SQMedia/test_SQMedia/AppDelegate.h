//
//  AppDelegate.h
//  test_SQMedia
//
//  Created by Shi Eric on 7/6/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  1.Add head search path for SQLibs.
 *  2.Add system framework for SQMedia(SQSoundManager) - (AudioToolbox.framework, AVFoundation.framework)
 *  
 *  If you need to play sound in the backgroud, modify AudioSession Category to "AVAudioSessionCategoryPlayback" in SQSoundManager.mm line 64 and add 
 *  Required background modes in app info.plist for key "App plays audio".
 */

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
