//
//  ColorUtils.h
//
//  Created by shjborage on Nov 11,2011.
//  Copyright 2011 shjSafe&Quick[http://blog.sina.com.cn/shjborage] All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(x, y, z) [UIColor colorWithRed:(x / 255.0) green:(y / 255.0) blue:(z / 255.0) alpha:1.0]

@interface UIColor (UIColorUtils)
+ (void)initColorScheme;

+ (UIColor *)navigationColor;
+ (UIColor *)cellLabelColor;
+ (UIColor *)conversationBackground;
- (UIImage *)createImage;   // add by shjborage@gmail.com May 28, 2012
@end