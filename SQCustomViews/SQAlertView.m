//
//  SQAlertView.m
//  iMagazine
//
//  Created by Shi Eric on 3/25/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import "SQAlertView.h"
#import "SQStringUtils.h"

@implementation SQAlertView

static UIAlertView *g_Alert = nil;
static SQAlertView *g_Instance = nil;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)index
{
    if (_delegate != nil) {
        if ([_delegate respondsToSelector:_action])
            [_delegate performSelector:_action withObject:g_Alert withObject:[NSNumber numberWithInteger:index]];
    } else {
        g_Alert = nil;
    }
    
    _delegate = nil;
    _action = nil;
}

+ (id)defaultAlert
{
    if (g_Instance == nil)
        g_Instance = [[SQAlertView alloc] init];
    
    g_Alert = nil;
    
    return g_Instance;
}

- (void)alert:(NSString *)strTitle 
      message:(NSString *)strMsg
{
    _delegate = nil;
    _action = nil;
    
    if (g_Alert)
        return;
    
    g_Alert = [[UIAlertView alloc] initWithTitle:strTitle
                                         message:strMsg
                                        delegate:nil
                               cancelButtonTitle:[NSString localizedString:@"global_OK"]
                               otherButtonTitles:nil];
    [g_Alert show];
    [g_Alert release];
}

- (void)alert:(NSString *)strTitle 
      message:(NSString *)strMsg
     delegate:(id)delegate
       action:(SEL)action
{
    _delegate = delegate;
    _action = action;
    
    if (g_Alert)
        return;
    
    g_Alert = [[UIAlertView alloc] initWithTitle:strTitle
                                         message:strMsg
                                        delegate:self
                               cancelButtonTitle:[NSString localizedString:@"global_Cancel"]
                               otherButtonTitles:[NSString localizedString:@"global_OK"], nil];
    [g_Alert show];
    [g_Alert release];
}

#pragma mark - prompt message

- (void)promptMessage:(NSString *)strMsg 
           atDuration:(NSTimeInterval)dDuration
               atMode:(MBProgressHUDMode)mode
{
    if (HUD != nil && mode == HUD.mode && [HUD.labelText isEqualToString:strMsg]) {
        return;
    }
    
    if (HUD != nil) {
        [HUD removeFromSuperview];
        [HUD release];
        HUD = nil;
    }
    
    HUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] keyWindow]];
    [[[UIApplication sharedApplication] keyWindow] addSubview:HUD];
    
    HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
    
    // Set custom view mode
    HUD.mode = mode;
    
    HUD.delegate = self;
    HUD.labelText = strMsg;
    
    [HUD show:YES];
    
    if (dDuration > 0.0f)
        [HUD hide:YES afterDelay:dDuration];
    else
        ;   // call stop manual
}

-(void)stopPromptMessage
{
    [HUD hide:YES];
}

-(void)setDimBackground:(BOOL)bDim
{
    if (HUD == nil)
        return;
    
    // 类似Alert，四周画激变的效果
    HUD.dimBackground = bDim;
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud 
{
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    [HUD release];
	HUD = nil;
}

@end
