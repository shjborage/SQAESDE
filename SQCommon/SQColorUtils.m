//
//  ColorUtils.m
//
//  Created by shjborage on Nov 11,2011.
//  Copyright 2011 shjSafe&Quick[http://blog.sina.com.cn/shjborage] All rights reserved.
//

#import "SQColorUtils.h"

static UIColor *gNavigationBarColors[1];

@implementation UIColor (UIColorUtils)

+ (void)initColorScheme
{
    gNavigationBarColors[0] = [UIColor colorWithRed:108/255.0 green:196/255.0 blue:220/255.0 alpha:1.0];
}

+ (UIColor*)navigationColor
{
    return gNavigationBarColors[0];
}

+ (UIColor*)cellLabelColor
{
    return [UIColor colorWithRed:0.195 green:0.309 blue:0.520 alpha:1.0];
}

+ (UIColor*)conversationBackground
{
    return [UIColor colorWithRed:0.859 green:0.886 blue:0.929 alpha:1.0];
}

@end
