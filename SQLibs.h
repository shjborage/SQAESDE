//
//  SQLibs.h
//  iMagazine
//
//  Created by Shi Eric on 3/25/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

/*
 *  For common usage.
 *  1.Add head search path for SQLibs.
 *  2.Add "Other Link Flags" -ObjC
 *  3.Add Library or library project(dependence).
 */

// remember to add System Library below when needed:
// 1.QuartzCore.framework
// 2.AVFoundation.framework (SQMedia)
// 3.AudioToolbox.framework (SQMedia)

// Localizable.strings (SQAlertView)
// "global_Done"    = "完成";
// "global_OK"      = "确定";
// "global_Cancel"  = "取消";

#ifndef _SQLibs_h
#define _SQLibs_h

// SQCommon
#import "SQColorUtils.h"
#import "SQStringUtils.h"
#import "SQDebugUtils.h"
#import "SQGlobalMarco.h"

// SQCustomViews
#import "SQLoadingViewController.h"
#import "SQMaskView.h"
#import "SQAlertView.h"

// SQGridView
#import "SQGridScrollView.h"

// SQMedia
#import "SQSoundManager.h"

// SQTabBar
#import "SQTabBarController.h"

#endif
