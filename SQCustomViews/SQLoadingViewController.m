//
//  PrivateLoadingViewController.m
//
//  Created by shjborage on 11/21/11.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import "SQLoadingViewController.h"
#import <QuartzCore/QuartzCore.h>

static SQLoadingViewController *g_LoadingView;

@implementation SQLoadingViewController

@synthesize m_ivMain, m_aiView;
@synthesize style = _style;

#warning 有时间把这个系统版本整理一下，封装起来

- (BOOL)extendVersion
{
	NSString *lSystemVersion = [[UIDevice currentDevice] systemVersion]; 
	float ver = 0.0;
	if(lSystemVersion.length > 0)
		ver = [lSystemVersion doubleValue];
    
    if (ver < 5.0) {
        return TRUE;
    }
    else {
        return FALSE;
    }
	return TRUE;
}

// warning end

- (void)dealloc
{
    [m_ivMain release];
    [m_aiView release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithStyle:(LoadingStyle)style
{
    self = [super init];
    if (self) {
        _style = style;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.userInteractionEnabled = YES;
}

- (void)loadView
{
    [super loadView];
    // Do any additional setup after loading the view from its nib.
    
    if (_style == LS_Custom) {
        if (m_ivMain == nil) {
            m_ivMain = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
            m_ivMain.frame = CGRectMake(124, 204, 71, 71);
            m_ivMain.layer.anchorPoint = CGPointMake(0.5, 0.5);
        }
        
        if (m_ivMain.superview == nil)
            [self.view addSubview:m_ivMain];
        
        float rotateAngle = M_PI;
        CGAffineTransform transform = CGAffineTransformMakeRotation(rotateAngle);
        m_ivMain.transform = transform;
    } else {
        if (m_aiView == nil) {
            m_aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            m_aiView.center = self.view.center;
            
            if (![self extendVersion])
                m_aiView.color = [UIColor blackColor];
        }
        
        if (m_aiView.superview == nil)
            [self.view addSubview:m_aiView];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.m_ivMain = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - public

+ (SQLoadingViewController *)defaultLoadingView
{
    if (g_LoadingView == nil) {
        g_LoadingView = [[SQLoadingViewController alloc] initWithStyle:LS_Standard];
        g_LoadingView.view.frame = [[UIScreen mainScreen] bounds];
    }
    return g_LoadingView;
}

#pragma mark - main funcion

-(void)rotation
{
    if (m_bStop) {
        m_bAnimated = NO;
        return;
    }
    
    [self.m_ivMain setTransform:CGAffineTransformMakeRotation(m_nRotate * 0.1)];
    [self performSelector:@selector(rotation) withObject:nil afterDelay:0.03];
    m_nRotate++;
}

#pragma mark - public

- (void)startAnimating
{
    self.view.hidden = NO;
    
    if (_style == LS_Custom) {
        if (m_bAnimated)
            return;
        
        m_bStop = NO;
        
        if (m_ivMain == nil) {
            m_ivMain = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
            m_ivMain.frame = CGRectMake(124, 204, 71, 71);
            m_ivMain.layer.anchorPoint = CGPointMake(0.5, 0.5);
        }
        
        if (m_ivMain.superview == nil)
            [self.view addSubview:m_ivMain];
        
        float rotateAngle = M_PI;
        CGAffineTransform transform = CGAffineTransformMakeRotation(rotateAngle);
        m_ivMain.transform = transform;
        
        m_bAnimated = YES;
        [self performSelector:@selector(rotation)];
    } else {
        if (m_aiView == nil) {
            m_aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            m_aiView.center = self.view.center;
            
            if ([self extendVersion])
                m_aiView.color = [UIColor blackColor];
        }
        
        if (m_aiView.superview == nil)
            [self.view addSubview:m_aiView];
        
        [m_aiView startAnimating];
    }
    
    if (self.view.superview == nil)
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.view];
}

- (void)stopAnimating
{
    self.view.hidden = YES;
    if (self.view.superview != nil)
        [self.view removeFromSuperview];
    
    if (_style == LS_Custom) {
        m_bStop = YES;
        m_nRotate = 0;
    } else {
        [m_aiView stopAnimating];
    }
}

@end
