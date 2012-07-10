//
//  ColorUtils.m
//
//  Created by shjborage on Nov 11,2011.
//  Copyright 2011 Safe&Quick[http://blog.sina.com.cn/shjborage] All rights reserved.
//

#import "SQColorUtils.h"

@implementation UIColor (UIColorUtils)

- (UIImage *)createImage
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
