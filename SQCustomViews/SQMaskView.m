//
//  SQMaskView.m
//  iMagazine
//
//  Created by Shi Eric on 3/3/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import "SQMaskView.h"

@implementation SQMaskView

@synthesize type = _type;
@synthesize rcMask = _rcMask;

- (void)dealloc
{
    
    [super dealloc];
}

- (SQMaskView *)initWithType:(MaskType)type
{
    self = [super init];
    if (self) {
        _type = type;
        _rcMask = CGRectZero;
    }
    return self;
}

- (SQMaskView *)initWithType:(MaskType)type atRect:(CGRect)rcMask
{
    self = [super init];
    if (self) {
        _type = type;
        
        if (type == MT_CUSTOM)
            _rcMask = rcMask;
        else
            _rcMask = CGRectZero;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UIView *_vTmp = [[UIView alloc] init];
    _vTmp.backgroundColor = [UIColor blackColor];
    _vTmp.alpha = kMaskViewAlpha;
    if (_type == MT_FULLSCREEN) {
        NSInteger nWidth, nHeight;
        if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
            nWidth = 1024, nHeight = 768;
        } else {
            nWidth = 768, nHeight = 1024;
        }
        
        _vTmp.frame = CGRectMake(0.0f, 0.0f, nWidth * 2, nHeight * 2);  // tmp xxx * 2 sorry.
    } else {
        _vTmp.frame = _rcMask;
    }
    _vTmp.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.view = _vTmp;
    [_vTmp release];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
