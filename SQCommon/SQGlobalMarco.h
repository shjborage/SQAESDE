//
//  SQGlobalMarco.h
//
//  Created by Shi Eric on 3/18/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#ifndef _SQGlobalMarco_h
#define _SQGlobalMarco_h

#define SQ_SAFERELEASE(foo) {if(foo != nil) {[foo release]; foo = nil;}}

#define SQ_ISORIENTATION_LANDSCAPE (UIInterfaceOrientationIsLandscape\
([[UIApplication sharedApplication] statusBarOrientation]))

#define SQ_ISPAD ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)]\
&& [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#endif
