//
//  SQTabBarController.m
//  iMagazine
//
//  Created by shjborage on 2/19/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage] All rights reserved.
//

#import "SQTabBarController.h"
#import "SQBadgeView.h"
#import "Constant.h"

@implementation SQTabBarController

@synthesize arButtons = _arButtons;
@synthesize nCurrentSelectedIndex = _nCurrentSelectedIndex;
@synthesize viewTitles = _viewTitles;

static BOOL g_bFirstTime =YES;

- (void)dealloc
{
    [_arButtons release];
    [_ivSlideBg release];
    [_ivBackGroundImageView release];
    [_vCustomTabBarView release];
    [_viewTitles release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation); 
}

- (void)viewDidAppear:(BOOL)animated
{
	if (g_bFirstTime) {
        NSNotificationCenter *notifCenter = [NSNotificationCenter defaultCenter];
		[notifCenter removeObserver:self name:kSQTabBarHide object:nil];
		[notifCenter addObserver:self
                        selector:@selector(hideCustomTabBar)
                            name:kSQTabBarHide
                          object:nil];
		[notifCenter removeObserver:self name:kSQTabBarShow object:nil];
		[notifCenter addObserver:self
                        selector:@selector(bringCustomTabBarToFront)
                            name:kSQTabBarShow
                          object:nil];
		[notifCenter removeObserver:self name:@"setBadge" object:nil];
		[notifCenter addObserver:self
                        selector:@selector(setBadge:)
                            name:@"setBadge"
                          object:nil];
		
		_ivSlideBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slide"]];
		[self hideRealTabBar];
		[self customTabBar];
		g_bFirstTime = NO;
	}
}

#pragma mark - new

- (void)hideRealTabBar
{
	for(UIView *view in self.view.subviews) {
		if([view isKindOfClass:[UITabBar class]]) {
			view.hidden = YES;
			break;
		}
	}
}

- (void)setBadge:(NSNotification *)_notification
{
	NSString *badgeValue = [_notification object];
	UIButton *btn = [self.arButtons objectAtIndex:self.selectedIndex];
	SQBadgeView *badgeView = [[SQBadgeView alloc] initWithFrame:CGRectMake(btn.bounds.size.width/2, 0, 30, 20)];
	badgeView.badgeString = badgeValue;
	badgeView.badgeColor = [UIColor blueColor];
	badgeView.tag = self.selectedIndex;
	badgeView.delegate = self;
	[btn addSubview:badgeView];
	[badgeView release];
}

//自定义tabbar
- (void)customTabBar
{
    for(UIView *view in self.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
            ;//[view setFrame:CGRectMake(0.0f, 44.0f, 100.0f, 724.0f)];
        else
            [view setFrame:CGRectMake(0.0f, 0.0f, 1024.0f, 1024.0f)];
    }
    // 添加个人中心相关的展示
    
	_vCustomTabBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 64.0f, 100.0f, 704.0f)];

	// 设置tabbar背景
    _ivBackGroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"下面功能底栏"]];
	_ivBackGroundImageView.frame = CGRectMake(0.0f, 64.0f, 100.0f, 704.0f);//self.tabBar.frame;
//    [self.view addSubview:_ivBackGroundImageView];
    [_ivBackGroundImageView release];
    
	_vCustomTabBarView.backgroundColor = kGrayColor;
	
	// 创建按钮
	int nViewCount = self.viewControllers.count > 5 ? 5 : self.viewControllers.count;
	self.arButtons = [NSMutableArray arrayWithCapacity:nViewCount];
    
	double _width = 80.0f, _yBegin = 0.0f;
    double _height = self.tabBar.frame.size.height;
    
    _yBegin = (_vCustomTabBarView.frame.size.height - (_height + 30.0f) * nViewCount) / 2 + 50.0f;

	for (int i = 0; i < nViewCount; i++) {
		UIViewController *v = [self.viewControllers objectAtIndex:i];
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.autoresizingMask=UIViewAutoresizingFlexibleWidth;
		btn.frame = CGRectMake(10, _yBegin + i*(_height + 30.0f), _width, _height);
		[btn addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchDown];
		btn.tag = i;
		[btn setBackgroundImage:v.tabBarItem.image forState:UIControlStateNormal];
		[btn setImageEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, 0)];
		// 添加标题
		UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _height-19, _width, _height-30)];
		titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        
        if ([_viewTitles count] > i)
            titleLabel.text = [_viewTitles objectAtIndex:i];
        else
            titleLabel.text = v.tabBarItem.title;
        
		[titleLabel setFont:[UIFont systemFontOfSize:12]];
		titleLabel.textAlignment = 1;
		titleLabel.textColor = [UIColor blackColor];
		[btn addSubview:titleLabel];
		[titleLabel release];		
		
		[self.arButtons addObject:btn];
/*        
		//添加按钮之间的分割线,第一个位置和最后一个位置不需要添加
		if (i>0 && i<4) {
			UIImageView *splitView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"split"]];
			splitView.frame = CGRectMake(i*_width-1,0,splitView.frame.size.width,splitView.frame.size.height);
			[_vCustomTabBarView addSubview:splitView];
			[splitView release];
		}
		
		//添加Badge
		if (v.tabBarItem.badgeValue) {
			SQBadgeView *badgeView = [[SQBadgeView alloc] initWithFrame:CGRectMake(_width/2, 0, 30, 20)];
			badgeView.badgeString = v.tabBarItem.badgeValue;
			badgeView.badgeColor = [UIColor orangeColor];
			[btn addSubview:badgeView];
			[badgeView release];
		}
 */
		[_vCustomTabBarView addSubview:btn];
	}
 
	[self.view addSubview:_vCustomTabBarView];
	[_vCustomTabBarView addSubview:_ivSlideBg];
	[_vCustomTabBarView release];
    [self performSelector:@selector(selectedTabNoAnimated:) 
               withObject:[self.arButtons objectAtIndex:0]];
}

//将自定义的tabbar显示出来
- (void)bringCustomTabBarToFront
{
    [self performSelector:@selector(hideRealTabBar)];
    [_vCustomTabBarView setHidden:NO];
//    _ivBackGroundImageView.hidden = NO;
/*    CAKeyframeAnimation * animation; 
	animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"]; 
	animation.duration = 0.25;
	animation.delegate = self;
	animation.removedOnCompletion = YES;
	animation.fillMode = kCAFillModeForwards;
	NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
	animation.values = values;
	[_vCustomTabBarView.layer addAnimation:animation forKey:nil];
 */
}

- (void)makeTabBarHidden:(BOOL)bHide
{
    if ([self.view.subviews count] < 2)
        return;
    
    UIView *contentView;
    
    if ([[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        contentView = [self.view.subviews objectAtIndex:1];
    else
        contentView = [self.view.subviews objectAtIndex:0];
    
    if (bHide) {
        contentView.frame = self.view.bounds;        
    } else {
        contentView.frame = CGRectMake(self.view.bounds.origin.x,
                                       self.view.bounds.origin.y,
                                       self.view.bounds.size.width,
                                       self.view.bounds.size.height - self.tabBar.frame.size.height);
    }
    
    self.tabBar.hidden = bHide;
}

//隐藏自定义tabbar
- (void)hideCustomTabBar
{
	[self performSelector:@selector(hideRealTabBar)];
/*    CAKeyframeAnimation * animation; 
	animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"]; 
	animation.duration = 0.1;
	animation.delegate = self;
	animation.removedOnCompletion = YES;
	animation.fillMode = kCAFillModeForwards;
	NSMutableArray *values = [NSMutableArray array];
	[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)]];
	animation.values = values;
	[_vCustomTabBarView.layer addAnimation:animation forKey:nil];
 */
    _vCustomTabBarView.hidden = YES;
//    _ivBackGroundImageView.hidden = YES;
    
    [self makeTabBarHidden:YES];
}

//动画结束回调
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim.duration==0.1) {
        [_vCustomTabBarView setHidden:YES];
    }
}

#pragma mark - switch select index

- (void)selectedTab:(UIButton *)button
{    
	if (self.nCurrentSelectedIndex == button.tag) {
        if ([[self.viewControllers objectAtIndex:button.tag] isKindOfClass:[UINavigationController class]]) {
            [[self.viewControllers objectAtIndex:button.tag] popToRootViewControllerAnimated:YES];
        }
        
        [self performSelector:@selector(selectedTabNoAnimated:) 
                   withObject:[self.arButtons objectAtIndex:button.tag]];
        
        if ([self.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:atCurrent:)])
            [self.delegate performSelector:@selector(tabBarController:didSelectViewController:atCurrent:)
                                withObject:self 
                                withObject:[self.viewControllers objectAtIndex:button.tag]];
        
		return;
	}
	
    self.nCurrentSelectedIndex = button.tag;
	
    [self setSelectedIndex:_nCurrentSelectedIndex atAnimate:NO];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex atAnimate:(BOOL)bAnimate
{
    self.nCurrentSelectedIndex = selectedIndex;
    _nCurrentSelectedEffectIndex = selectedIndex;
    [super setSelectedIndex:selectedIndex];
    
    if (bAnimate) {
        [self performSelector:@selector(selectedTab:) 
                   withObject:[self.arButtons objectAtIndex:selectedIndex]];
    } else {
        [self performSelector:@selector(selectedTabNoAnimated:) 
                   withObject:[self.arButtons objectAtIndex:selectedIndex]];
    }
    
    if ([self.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)])
        [self.delegate performSelector:@selector(tabBarController:didSelectViewController:)
                            withObject:self 
                            withObject:[self.viewControllers objectAtIndex:_nCurrentSelectedIndex]];
}

- (void)setSelectEffect:(NSUInteger)uEffectIndex atAnimate:(BOOL)bAnimate
{
    _nCurrentSelectedEffectIndex = uEffectIndex;
    if (bAnimate) {
        [self performSelector:@selector(selectedTab:) 
                   withObject:[self.arButtons objectAtIndex:uEffectIndex]];
    } else {
        [self performSelector:@selector(selectedTabNoAnimated:) 
                   withObject:[self.arButtons objectAtIndex:uEffectIndex]];
    }
}

- (void)selectedTabNoAnimated:(UIButton *)btn
{
	_ivSlideBg.frame = btn.frame;
}

//切换滑块位置
- (void)slideTabBg:(UIButton *)btn
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.20]; 
	[UIView setAnimationDelegate:self];
	_ivSlideBg.frame = btn.frame;
	[UIView commitAnimations];
	CAKeyframeAnimation * animation; 
	animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"]; 
	animation.duration = 0.50; 
	animation.delegate = self;
	animation.removedOnCompletion = YES;
	animation.fillMode = kCAFillModeForwards;
	NSMutableArray *values = [NSMutableArray array];
	[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
	[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]]; 
	[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]]; 
	[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
	animation.values = values;
	[btn.layer addAnimation:animation forKey:nil];
}

@end
