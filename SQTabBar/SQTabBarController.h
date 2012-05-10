//
//  SQTabBarController.h
//  iMagazine
//
//  Created by shjborage on 2/19/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage] All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSQTabBarHide   @"SQ_hideCustomTabBar"
#define kSQTabBarShow   @"SQ_bringCustomTabBarToFront"

@interface SQTabBarController : UITabBarController
{
    NSMutableArray *_arButtons;
	
	UIImageView *_ivSlideBg;
    UIImageView *_ivBackGroundImageView;
	UIView *_vCustomTabBarView;
    NSArray *_viewTitles;
    
    NSInteger _nCurrentSelectedIndex;
    NSInteger _nCurrentSelectedEffectIndex;
}

@property (nonatomic, assign) NSInteger nCurrentSelectedIndex;
@property (nonatomic, retain) NSMutableArray *arButtons;
@property (nonatomic, retain) NSArray *viewTitles;

- (void)hideRealTabBar;
- (void)customTabBar;
- (void)selectedTab:(UIButton *)btn;
- (void)setSelectedIndex:(NSUInteger)selectedIndex atAnimate:(BOOL)bAnimate;
- (void)setSelectEffect:(NSUInteger)uEffectIndex atAnimate:(BOOL)bAnimate;

@end
