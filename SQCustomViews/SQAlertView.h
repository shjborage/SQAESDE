//
//  SQAlertView.h
//  iMagazine
//
//  Created by Shi Eric on 3/25/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface SQAlertView : UIViewController
<MBProgressHUDDelegate>
{
    id _delegate;
    SEL _action;
    
    MBProgressHUD *HUD;
    
    UIWindow *_windowPrompt;
}

+ (id)defaultAlert;

- (void)alert:(NSString *)strTitle 
      message:(NSString *)strMsg;

- (void)alert:(NSString *)strTitle 
      message:(NSString *)strMsg
     delegate:(id)delegate
       action:(SEL)action;

// public add by shjborage@gmail.com Feb 24, 2012
- (void)promptMessage:(NSString *)strMsg 
           atDuration:(NSTimeInterval)dDuration
               atMode:(MBProgressHUDMode)mode;
-(void)stopPromptMessage;
-(void)setDimBackground:(BOOL)bDim;

@end
