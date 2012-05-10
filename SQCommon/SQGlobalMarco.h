//
//  SQGlobalMarco.h
//  iMagazine
//
//  Created by Shi Eric on 3/18/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#ifndef iMagazine_SQGlobalMarco_h
#define iMagazine_SQGlobalMarco_h

#define SQ_SAFERELEASE(foo) { if(foo != nil) {[foo release]; foo = nil;} }

#define SQ_ISORIENTATION_LANDSCAPE (UIInterfaceOrientationIsLandscape\
([[UIApplication sharedApplication] statusBarOrientation]))

#endif
