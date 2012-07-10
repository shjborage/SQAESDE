//
//  AppDelegate.m
//  test_SQMedia
//
//  Created by Shi Eric on 7/6/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import "AppDelegate.h"
#import "SQLibs.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (void)test
{
    UIButton *t_btnPlay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    t_btnPlay.frame = CGRectMake(50.0f, 50.0f, 100.0f, 29.0f);
    [t_btnPlay setTitle:@"Play" forState:UIControlStateNormal];
    t_btnPlay.tag = 1;
    [t_btnPlay addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:t_btnPlay];
    
    UIButton *t_btnStop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    t_btnStop.frame = CGRectMake(self.window.frame.size.width - 100.0f - 50.0f, 50.0f, 100.0f, 29.0f);
    [t_btnStop setTitle:@"Stop" forState:UIControlStateNormal];
    t_btnStop.tag = 2;
    [t_btnStop addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:t_btnStop];
}

#pragma mark - actions

- (void)btnPressed:(id)sender
{
    UIButton *t_btn = (UIButton *)sender;
    if (t_btn.tag == 1)
        [[SQSoundManager defaultManager] playCafFile:[[NSBundle mainBundle] pathForResource:@"Travel" ofType:@"caf"] volume:1.0f];
    else 
        [[SQSoundManager defaultManager] stop];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self test];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
