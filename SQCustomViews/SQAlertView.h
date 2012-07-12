//
//  SQAlertView.h
//  iMagazine
//
//  Created by Shi Eric on 3/25/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "MTStatusBarOverlay.h"

@interface SQAlertView : UIViewController
<
MBProgressHUDDelegate,
MTStatusBarOverlayDelegate
>
{
    id _delegate;
    
    // - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSNumber *)nnIndex
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
- (void)stopPromptMessage;
- (void)setDimBackground:(BOOL)bDim;
- (void)setUserInteraction:(BOOL)bEnable;

- (void)postStatusBarMessage:(NSString *)strMsg 
                      atType:(MTMessageType)type 
                  atDuration:(NSTimeInterval)dDuration
                    animated:(BOOL)bAnimated;

@end
