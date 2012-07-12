//
//  SQGridScrollView.m
//  SQGridView
//
//  Created by Shi Eric on 3/2/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import "SQGridScrollView.h"

@interface SQGridScrollView (private)
- (CGSize)contentSizeAdapter;
@end

@implementation SQGridScrollView (private)

- (CGSize)contentSizeAdapter
{
    if (nil == self.sdataSource)
        return CGSizeZero;
    
    if ([_sdataSource respondsToSelector:@selector(gridViewContentSizeAdapter)])
        return [_sdataSource gridViewContentSizeAdapter];
    
    CGSize size = CGSizeZero;
    
    CGSize cellSize = [_sdataSource gridViewCellSize:nil];
    
    CGFloat fInterVal = 0.0f;
    NSInteger columns;
    NSInteger rows;
    NSUInteger uTotal = [_sdataSource gridViewNumberOfAllCells:self];
       
    if (GRIDSCROLL_HORIZONTAL_STYLE == self.style) {
        fInterVal = [_sdataSource gridViewSizeOfColumnInterval:_visiblePage];
        rows = [_sdataSource gridViewNumberOfRows:nil];
        
        if (uTotal % rows == 0)
            columns = uTotal / rows;
        else
            columns = uTotal / rows + 1;
        
        if (columns != 0)
            size = CGSizeMake((cellSize.width + fInterVal) * columns, self.bounds.size.height);
        else
            size = CGSizeMake(cellSize.width + fInterVal, self.bounds.size.height);
    } else {
        fInterVal = [_sdataSource gridViewSizeOfRowInterval:_visiblePage];
        columns = [_sdataSource gridViewNumberOfColumns:nil];
        
        if (uTotal % columns == 0)
            rows = uTotal / columns;
        else
            rows = uTotal / columns + 1;
        
        if (rows != 0)
            size = CGSizeMake(self.bounds.size.width, rows * (cellSize.height + fInterVal));
        else
            size = CGSizeMake(self.bounds.size.width, (cellSize.height + fInterVal));
    }

    return size;
}

@end


@implementation SQGridScrollView

@synthesize visiblePage = _visiblePage;
@synthesize scrollViewDelegate = _scrollViewDelegate;
@synthesize sdelegate = _sdelegate;
@synthesize sdataSource = _sdataSource;
@synthesize style = _style;

- (void)dealloc
{
    self.visiblePage = nil;
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
        self.delegate = self;
        self.pagingEnabled =  NO;
        
        self.autoresizesSubviews=YES;
        self.Style = GRIDSCROLL_VERTICAL_STYLE;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
//    [self reload];
}

- (void)reload:(BOOL)bAnimated
{
    if (nil == _sdataSource)
        return;
    
    self.contentSize = [self contentSizeAdapter];
    
/*    if (self.pagingEnabled) {
        CGPoint offSetNew = _shopContentOffset;
        if (self.frame.size.width == 768.0f) {
            offSetNew.x = _shopContentOffset.x / 1024.0f * 768.0f;
        } else {
            offSetNew.x = _shopContentOffset.x / 768.0f * 1024.0f;
        }
        [self setContentOffset:offSetNew];
    }
 */
    
    if (nil == _visiblePage) {        
        _visiblePage = [[SQGridView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
        _visiblePage.dataSource = _sdataSource;
        _visiblePage.delegate = _sdelegate;
        _visiblePage.style = _style;
        _visiblePage.bAnimated = bAnimated;
        _visiblePage.scrollView = self;
        [self addSubview:_visiblePage];
        [_visiblePage reload];
    } else {
        _visiblePage.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
        _visiblePage.bAnimated = bAnimated;
        _visiblePage.style = _style;
        [_visiblePage reload];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}

- (void)removeCellsArray:(NSUInteger)uIndex;
{
    [_visiblePage removeCellsArray:uIndex];;
}

- (void)removeCacheCells
{
    [_visiblePage removeCacheCells];
}

- (void)setbackGroundImage:(UIImage *)imgPortait imgLandscape:(UIImage *)imgLandscape;
{
    [_visiblePage setbackGroundImage:imgPortait imgLandscape:imgLandscape];
}

@end
