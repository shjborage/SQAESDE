//
//  SQMaskView.h
//  iMagazine
//
//  Created by Shi Eric on 3/3/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMaskViewAlpha  0.5f

typedef enum MASK_TYPE {
    MT_FULLSCREEN,
    MT_CUSTOM
} MaskType;

@interface SQMaskView : UIViewController
{
    MaskType _type;
    CGRect _rcMask;
}

@property (nonatomic, assign) MaskType type;
@property (nonatomic, assign) CGRect rcMask;


- (SQMaskView *)initWithType:(MaskType)type;
- (SQMaskView *)initWithType:(MaskType)type atRect:(CGRect)rcMask;

@end
