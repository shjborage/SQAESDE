//
//  SQDebugUtils.h
//
//  Created by shjborage on Nov 11,2011.
//  Copyright 2011 Safe&Quick[http://blog.sina.com.cn/shjborage] All rights reserved.
//

#import <UIKit/UIKit.h>

#define SQDEBUG

#ifdef SQDEBUG
#  define SQLOG(...) NSLog(__VA_ARGS__)
#  define SQLOG_RECT(r) NSLog(@"(%.1fx%.1f)-(%.1fx%.1f)", \
            r.origin.x, r.origin.y, r.size.width, r.size.height)
#else
#  define SQLOG(...) ;
#  define SQLOGRECT(r) ;
#endif

//SQLOG(@"file:%@ line:%d fun:%@ ...", __FILE_NAME__, __LINE__, __FUNC_NAME__, ...);

#define __FUNC_NAME__   NSStringFromSelector(_cmd)
#define __CLASS_NAME__  NSStringFromClass([self class])
#define __CALL_STACK__  [NSThread callStackSymbols]
#define __FILE_NAME__   [[NSString stringWithUTF8String:__FILE__] lastPathComponent]

/*
 
 // Detail: http://blog.sina.com.cn/s/blog_8732f19301010pwp.html
 
 __func__
 %s
 Current function signature.
 
 __LINE__
 %d
 Current line number in the source code file.
 
 __FILE__
 %s
 Full path to the source code file.
 
 __PRETTY_FUNCTION__
 %s
 Like __func__, but includes verbose type information in C++ code.

 */
