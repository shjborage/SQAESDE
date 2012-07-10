//
//  AppDelegate.m
//  test_CustomViews
//
//  Created by Shi Eric on 7/10/12.
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
    UIButton *t_btnAlert1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    t_btnAlert1.frame = CGRectMake(50.0f, 50.0f, 100.0f, 29.0f);
    [t_btnAlert1 setTitle:@"Info Alert" forState:UIControlStateNormal];
    t_btnAlert1.tag = 1;
    [t_btnAlert1 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:t_btnAlert1];
    
    UIButton *t_btnAlert2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    t_btnAlert2.frame = CGRectMake(self.window.frame.size.width - 100.0f - 50.0f, 50.0f, 100.0f, 29.0f);
    [t_btnAlert2 setTitle:@"Confirm Alert" forState:UIControlStateNormal];
    t_btnAlert2.tag = 2;
    [t_btnAlert2 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:t_btnAlert2];
}

#pragma mark - actions

- (void)btnPressed:(id)sender
{
    UIButton *t_btn = (UIButton *)sender;
    if (t_btn.tag == 1) {
        [[SQAlertView defaultAlert] alert:@"info" message:@"this is a info alert"];
    } else if (t_btn.tag == 2) {
        [[SQAlertView defaultAlert] alert:@"info" message:@"this is a comfirm alert, ok?" delegate:self action:@selector(alertView:clickedButtonAtIndex:)];
    }
}

#pragma mark - confirm alert

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSNumber *)nnIndex
{
    SQLOG(@"btn index:%d", [nnIndex integerValue]);
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
