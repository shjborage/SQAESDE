//
//  ColorUtils.h
//
//  Created by shjborage on Nov 11,2011.
//  Copyright 2011 Safe&Quick[http://blog.sina.com.cn/shjborage] All rights reserved.
//

#import <UIKit/UIKit.h>

// For Hex, x,y,z maybe 0x00~0xFF
#define RGB(x, y, z) [UIColor colorWithRed:(x/255.0) green:(y/255.0) blue:(z/255.0) alpha:1.0]

@interface UIColor (UIColorUtils)

- (UIImage *)createImage;   // add by shjborage@gmail.com May 28, 2012

@end