//
//  AppDelegate.h
//  test_SQCommon
//
//  Created by Shi Eric on 7/6/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewController.h"

/*
 *  1.Add head search path for SQLibs.
 *  2.Add "Other Link Flags" -ObjC
 *  3.Add Library or library project(dependence).
 */

@interface AppDelegate : UIResponder
<
UIApplicationDelegate
>
{
    TestViewController *_vcRoot;
}

@property (nonatomic, retain, readonly) TestViewController *vcRoot;
@property (strong, nonatomic) UIWindow *window;

@end
