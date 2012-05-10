//
//  SQLoadingViewController.h
//
//  Created by shjborage on 11/21/11.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LS_Standard = 1,
    LS_Custom
} LoadingStyle;

@interface SQLoadingViewController : UIViewController
{
    UIImageView *m_ivMain;
    BOOL m_bStop;
    int m_nRotate;
    BOOL m_bAnimated;
    
    UIActivityIndicatorView *m_aiView;
    
    LoadingStyle _style;
}

@property (nonatomic, retain) UIImageView *m_ivMain;
@property (nonatomic, retain) UIActivityIndicatorView *m_aiView;

@property LoadingStyle style;

- (id)initWithStyle:(LoadingStyle)style;

- (void)startAnimating;
- (void)stopAnimating;

+ (SQLoadingViewController *)defaultLoadingView;

@end
