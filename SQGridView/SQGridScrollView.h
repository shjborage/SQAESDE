//
//  SQGridScrollView.h
//  SQGridView
//
//  Created by Shi Eric on 3/2/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQGridView.h"

@class SQGridScrollView;

@protocol SQGridScrollViewDelegate
@end

@interface SQGridScrollView : UIScrollView
<UIScrollViewDelegate>
{
    SQGridView *_visiblePage;
    GridScrollViewStyle _style;
    
    CGPoint _shopContentOffset; // just for iMagazine shop view.

    id<SQGridScrollViewDelegate> _scrollViewDelegate;
    id<SQGridViewDelegate> _sdelegate;
    id<SQGridViewDataSource> _sdataSource;
}

@property (nonatomic, retain) SQGridView *visiblePage;
@property (nonatomic, assign) id<SQGridScrollViewDelegate> scrollViewDelegate;
@property (nonatomic, assign) id<SQGridViewDelegate> sdelegate;
@property (nonatomic, assign) id<SQGridViewDataSource> sdataSource;

//default is GRIDSCROLL_VERTICAL_STYLE
@property (nonatomic, assign) GridScrollViewStyle style;

@property (nonatomic, assign) CGPoint shopContentOffset;

- (void)removeCellsArray:(NSUInteger)uIndex;

- (void)reload:(BOOL)bAnimated;
- (void)setbackGroundImage:(UIImage *)imgPortait imgLandscape:(UIImage *)imgLandscape;
- (void)removeCacheCells;

@end
