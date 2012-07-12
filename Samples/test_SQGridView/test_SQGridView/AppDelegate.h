//
//  AppDelegate.h
//  test_SQGridView
//
//  Created by Shi Eric on 7/11/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  1.Add head search path for SQLibs.
 *  2.Add Library or library project(dependence).
 *  
 *  This is a simple example. It shows a grid and you can long press one of them
 *  and move to switch pos of them(like iBooks).
 *
 *  Later, I will add the "Add, Delete" examples and switch datasource and so on.
 */

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
