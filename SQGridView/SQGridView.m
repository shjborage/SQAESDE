//
//  VCGridView.m
//  SQGridView
//
//  Created by Shi Eric on 3/2/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import "SQGridView.h"
#import "SQGridCell.h"
#import "SQGlobalMarco.h"

#define SCALE_ANIMATION 1			// 缩放效果
#define TOUCH_MOVE_EFFECT_DIST 15.0f// 有效移动距离
//! 删除激活时间 
#define DELETE_ACTIVING_TIME 0.5

// move item duration
#define LAYOUT_ANIMATION_DURATION   0.3

//! itemview在scrollview开始布局的origionw
#define LAYOUT_START_ORRIGIN CGPointMake(0, 0)

@interface SQGridView (private)
- (void)resetLayoutValues;
- (CGPoint)getCenterPointWithIndex:(NSInteger)index;
- (void)layoutItemViews;

// animation
- (void)scaleAnimationWithView:(UIView*)view;
- (void)removeAnimationWithView:(UIView*)view;
- (void)cancelDeleteAnimation;
- (void)showDeleteAnimation;
- (void)layCurrentView;
@end

@implementation SQGridView

@synthesize delegate = _delegate;
@synthesize dataSource = _dataSource;
@synthesize style = _style;
@synthesize ivBackGroundView = _ivBackGroundView;
@synthesize bAnimated, bFirst;
@synthesize m_allBookCells;
@synthesize scrollView;

- (void)dealloc
{
    SQ_SAFERELEASE(m_allBookCells);
    [_ivBackGroundView release];
    
    [super dealloc];
}

#pragma mark - private function

- (void)addVisibleCell:(SQGridCell *)cell atIndex:(NSUInteger)index
{    
    if (nil == cell) {
        return;
    }
    
    if (nil == m_allBookCells) {
        m_allBookCells = [[NSMutableArray alloc] init];
    }
    cell.delegate = self;
    cell.index = index;
    
    [m_allBookCells addObject:cell];
    [self addSubview:cell];
}

#pragma mark - init

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)reload
{
    [self resetLayoutValues];
    
    if (_dataSource == nil)
        return;
    
    _bCanMoveCell = [_dataSource gridViewCanMoveCell:self];
    
    int nAllBook = [_dataSource gridViewNumberOfAllCells:self];
    for (int nPos = 0; nPos < nAllBook; nPos ++) {
        SQGridCell *cell = nil;
        if (m_allBookCells != nil && (nPos) < [m_allBookCells count]) {
            cell = [m_allBookCells objectAtIndex:(nPos)];
            [_dataSource gridView:self visibleCell:cell forIndex:nPos];
        } else {
            cell = [_dataSource gridView:self visibleCell:nil forIndex:nPos];
            if (cell != nil)
                [self addVisibleCell:cell atIndex:nPos];
            else
                cell.index = nPos;
        }
    }
    
    [self clearView];
    [self layoutItemViews];
}

#pragma mark - public

- (void)setbackGroundImage:(UIImage *)imgPortait imgLandscape:(UIImage *)imgLandscape
{
    if (_ivBackGroundView == nil)
        _ivBackGroundView = [[UIImageView alloc] init];
    
    CGSize viewSize = [_dataSource gridViewCellSize:self];
    
    if (!SQ_ISORIENTATION_LANDSCAPE) {
        _ivBackGroundView.frame = CGRectMake(0, -1024.0f, 768, 2048 + rowCount * viewSize.height);
        [_ivBackGroundView setImage:imgPortait];
    } else {
        _ivBackGroundView.frame = CGRectMake(0, -1024.0f, 1024, 2048 + rowCount * viewSize.height);
        [_ivBackGroundView setImage:imgLandscape];
    }
    
    _ivBackGroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    if (_ivBackGroundView.superview == nil)
        [self addSubview:_ivBackGroundView];
}

- (void)clearView
{
    // all book
    for (int gridPosition = 0; gridPosition < [m_allBookCells count]; gridPosition ++) {
        SQGridCell *cell = [m_allBookCells objectAtIndex:gridPosition];
        
        [cell removeFromSuperview];
    }
}

- (void)removeCellsArray:(NSUInteger)uIndex
{
    if (m_allBookCells == nil)
        return;
    
    if ([m_allBookCells count] <= 0)
        return;
    
    if (uIndex >= [m_allBookCells count])
        return;
    
    SQGridCell *cell = [m_allBookCells objectAtIndex:uIndex];
    if (cell.superview)
        [cell removeFromSuperview];
    [m_allBookCells removeObjectAtIndex:uIndex];
}

- (void)removeCacheCells
{
    [self clearView];
    
    if (m_allBookCells != nil)
        [m_allBookCells removeAllObjects];
}

#pragma mark - thread & timer for long press

- (void)startTimerThead
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
	
	touchTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
												  target:self 
												selector:@selector(checkTouchTime:) 
												userInfo:nil repeats:YES];
	
	[runLoop run];
	[pool release];
}

- (void)stopTouchTimer
{
	if (touchTimer != nil) {
		[touchTimer invalidate];
		touchTimer = nil;
	}
	if (timerThread != nil) {
		[timerThread cancel];
		[timerThread release];
		timerThread = nil;		
	}
}

- (void)checkTouchTime:(NSTimer*)timer
{
	if (!scrollView.dragging) {
		if (!m_bMoving) {
			NSDate *nowDate = [NSDate date];
			NSTimeInterval didTouchTime = [nowDate timeIntervalSinceDate:touchStartTime];
			if (didTouchTime > DELETE_ACTIVING_TIME){
				m_bMoving = YES;
				
				[self stopTouchTimer];
				[self scaleAnimationWithView:currentSelectedView];
                NSLog(@"checkTouchTime scaleAnimationWithView");
                scrollView.scrollEnabled = NO;
                bAnimated = YES;
			}
		}
	} else {
		[self stopTouchTimer];
//		[self removeAlphaLayer];
	}
}

#pragma mark layout

/*
 *  Layout and order readme
 *  1.当前分类中显示m_currentClassCells中的index，和控件.tag一致，用来排序
 *  2.通过index或者控件的tag,getCenterPointWithIndex得到center point来决定Cell位置
 *  3.cell.m_bookinfo.m_n_order_tag,与数据库中一致，决定从数据库取出的顺序，并在切换
 *      位置时修改这个值，解决不同分类显示问题以及下载Cell对应问题（好像有Bug）
 */
- (void)layoutItemViews
{
    if (!bFirst) {
        // 第一次 不显示动画
        bAnimated = NO;
        bFirst = YES;
    }
    
	CGPoint centerPoint = CGPointZero;
	for (int i = 0; i < [m_allBookCells count]; ++i) {
		centerPoint = [self getCenterPointWithIndex:i];
		
		UIView *view = [m_allBookCells objectAtIndex:i];
		
		if (currentSelectedView != view) {
            if (bAnimated) {
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationBeginsFromCurrentState:YES];
                [UIView setAnimationDuration:LAYOUT_ANIMATION_DURATION];
                [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            }
			
			[view setCenter:centerPoint];
			
			if (nil == view.superview) {
				[self addSubview:view];
			}
            
            if (bAnimated)
                [UIView commitAnimations];
		} else {
            if (nil == view.superview) {
				[self addSubview:view];
                [self removeAnimationWithView:view];
                [view setCenter:centerPoint];
			}
        }
	}
}
 
#pragma mark - key exchange

- (void)resetLayoutValues
{
	CGSize viewSize = [_dataSource gridViewCellSize:self];
    NSUInteger uTotal = [_dataSource gridViewNumberOfAllCells:self];
    
    if (_style == GRIDSCROLL_VERTICAL_STYLE) {
        columnCount = [_dataSource gridViewNumberOfColumns:self];
        columnIntervalSpace = (scrollView.frame.size.width - viewSize.width * columnCount) / (columnCount+1);
        
        if (uTotal % columnCount == 0)
            rowCount = uTotal / columnCount;
        else
            rowCount = uTotal / columnCount + 1;

        if ([_dataSource respondsToSelector:@selector(gridViewSizeOfRowInterval:)])
            rowIntervalSpace = [_dataSource gridViewSizeOfRowInterval:self];
        else 
            rowIntervalSpace = 0.0f;
    } else {
        rowCount = [_dataSource gridViewNumberOfRows:self];
        rowIntervalSpace = (scrollView.frame.size.height - viewSize.height * rowCount) / (rowCount+1);
        
        if (uTotal % rowCount == 0)
            columnCount = uTotal / rowCount;
        else
            columnCount = uTotal / rowCount + 1;
        
        if ([_dataSource respondsToSelector:@selector(gridViewSizeOfRowInterval:)])
            columnIntervalSpace = [_dataSource gridViewSizeOfColumnInterval:self];
        else 
            columnIntervalSpace = 0.0f;
    }
}

- (CGPoint)getOriginPointWithIndex:(NSInteger)index
{
	CGSize viewSize = [_dataSource gridViewCellSize:self];
	
	int row = index / columnCount;
	int column = index % columnCount;

	CGPoint originPoint = CGPointMake(LAYOUT_START_ORRIGIN.x + columnIntervalSpace / 2 + column * (columnIntervalSpace + viewSize.width) , 
									  LAYOUT_START_ORRIGIN.y + rowIntervalSpace / 2 + row * (rowIntervalSpace + viewSize.height));
	return originPoint;
}

/*
 * 判断origin的x，y改变值，与(间隔距离+视图高或宽一半)比较
 */
- (BOOL)exchangeViewsPosition:(UIView*)touchView
{
    CGSize viewSize = [_dataSource gridViewCellSize:self];
    
	CGPoint baseOriginPoint = [self getOriginPointWithIndex:touchView.tag];
	
	// 现在的初始位置
	CGPoint currentOriginPoint = touchView.frame.origin;
	NSInteger exchangedIndex = touchView.tag;
	
	//<-- 不是行首
	if (touchView.tag % columnCount != 0
		&& currentOriginPoint.x - baseOriginPoint.x < -(columnIntervalSpace + viewSize.width * 0.5f)) {
		NSLog(@"left exchange!");
		exchangedIndex = touchView.tag - 1;
	}
	//--> 不是行尾且不是最后一个
	else if (touchView.tag % columnCount != columnCount - 1 && touchView.tag != [m_allBookCells count]-1
			 && currentOriginPoint.x - baseOriginPoint.x > (columnIntervalSpace + viewSize.width * 0.5f)) {
		NSLog(@"right exchange!");
		exchangedIndex = touchView.tag + 1;
	}
	//^
	//|
	else if (currentOriginPoint.y - baseOriginPoint.y < -(rowIntervalSpace + viewSize.height * 0.5f)) {
		NSLog(@"above exchange!");
		exchangedIndex = touchView.tag - columnCount;
	}
	//|
	//~
	else if (currentOriginPoint.y - baseOriginPoint.y > (rowIntervalSpace + viewSize.height * 0.5f)) {
		NSLog(@"below exchange!");
		exchangedIndex = touchView.tag + columnCount;
	}
	
	NSLog(@"exchanged index = %d", exchangedIndex);
	if ((exchangedIndex >= 0 && exchangedIndex < [m_allBookCells count]) 
		&& exchangedIndex != touchView.tag) {
		UIView *exchangedView = [m_allBookCells objectAtIndex:exchangedIndex];
		
		// 交换移动位置
		[exchangedView retain];
		[touchView retain];
		
		if (touchView.tag > exchangedView.tag) {
			// 从后面往后移动
			for (int i = touchView.tag-1; i >= exchangedView.tag; --i) {
				SQGridCell *cell = [m_allBookCells objectAtIndex:i];
				[m_allBookCells replaceObjectAtIndex:i + 1 withObject:cell];
                cell.tag = i + 1;
			}
		} else {
			// 从前面往前移动
			for (int i = touchView.tag + 1; i <= exchangedView.tag; ++i) {
				SQGridCell *cell = [m_allBookCells objectAtIndex:i];
				[m_allBookCells replaceObjectAtIndex:i - 1 withObject:cell];
                cell.tag = i - 1;
			}
		}
		
		touchView.tag = exchangedIndex;
		[m_allBookCells replaceObjectAtIndex:exchangedIndex withObject:touchView];
        
        if ([_delegate respondsToSelector:@selector(gridViewExchangeCell:exchangeCell:)])
            [_delegate gridViewExchangeCell:(SQGridCell *)touchView exchangeCell:(SQGridCell *)exchangedView];
		
		[exchangedView release];
		[touchView release];
		
		return YES;
	}
	return NO;
}

- (CGPoint)getCenterPointWithIndex:(NSInteger)index
{
    if ([_dataSource respondsToSelector:@selector(gridViewCellCenterPointWithIndex:)])
        return [_dataSource gridViewCellCenterPointWithIndex:index];
    
	CGSize viewSize = [_dataSource gridViewCellSize:self];
	CGPoint originPoint = [self getOriginPointWithIndex:index];
	
	CGPoint centerPoint = CGPointMake(originPoint.x + viewSize.width * 0.5, 
									  originPoint.y + viewSize.height * 0.5);
	return centerPoint;
}

#pragma mark - touch actions

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if (currentSelectedView != nil)
        [self layCurrentView];
    
    UITouch *touch = [touches anyObject];
	UIView *touchView = [touch view];
	if ([touchView isKindOfClass:[SQGridCell class]]) {
		currentSelectedView = touchView;
        [self bringSubviewToFront:currentSelectedView];
		[self removeAnimationWithView:currentSelectedView];
		
		if (!m_bMoving) {
			[touchStartTime release];
			touchStartTime = [[NSDate date] retain];
			
			//! 将定时器放入独立线程,保证在touch事件响应的同时也执行定时器的action
			if (nil == timerThread && _bCanMoveCell) {
				timerThread = [[NSThread alloc] initWithTarget:self selector:@selector(startTimerThead) object:nil];
				[timerThread start];
			}
		} else {
            [self cancelDeleteAnimation];
		}
		touchStartPoint = [touch locationInView:scrollView];
		lastTouchPoint = touchStartPoint;
	} else if (m_bMoving) { // 点击自身视图，取消动画
        [self cancelDeleteAnimation];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
	UITouch *touch = [touches anyObject];
	UIView *touchView = [touch view];
	CGPoint movedPoint = [touch locationInView:scrollView];
	CGPoint deltaVector = CGPointMake(movedPoint.x - touchStartPoint.x, movedPoint.y - touchStartPoint.y);
	
	if ([touchView isKindOfClass:[SQGridCell class]]) {
		[self removeAnimationWithView:currentSelectedView];
		
		if (m_bMoving) {
			CGPoint centerPoint = [self getCenterPointWithIndex:touchView.tag];
			// 添加一个动画
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationBeginsFromCurrentState:YES];
			[UIView setAnimationDuration:0.3];
			[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
			[touchView setCenter:centerPoint];
			[UIView commitAnimations];
		} else {
			// touch移动在可允许范围内，相应touch进入界面
			if (fabsf(deltaVector.x) < TOUCH_MOVE_EFFECT_DIST
				&& fabsf(deltaVector.y) < TOUCH_MOVE_EFFECT_DIST) {
				//todo: with delegate
				[_delegate gridView:self 
                      didSelectCell:(SQGridCell *)currentSelectedView 
                            atIndex:((SQGridCell *)currentSelectedView).index];
			} else {
                [self stopTouchTimer];
            }
		}
        currentSelectedView = nil;
        [self cancelDeleteAnimation];
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
	UIView *touchView = [touch view];
	CGPoint movedPoint = [touch locationInView:scrollView];
	CGPoint deltaVector = CGPointMake(movedPoint.x - touchStartPoint.x, movedPoint.y - touchStartPoint.y);
	
	if ([touchView isKindOfClass:[SQGridCell class]]) {
		// 首先移除透明层、动画
		[self removeAnimationWithView:currentSelectedView];
		
		if (m_bMoving) {
			
		} else {
			// touch移动在可允许范围内，相应touch进入界面
			if (fabsf(deltaVector.x) < TOUCH_MOVE_EFFECT_DIST
				&& fabsf(deltaVector.y) < TOUCH_MOVE_EFFECT_DIST) {
				if ([_delegate respondsToSelector:@selector(gridView:didSelectCell:atIndexPath:)])
                    [_delegate gridView:self 
                          didSelectCell:(SQGridCell *)currentSelectedView 
                                atIndex:((SQGridCell *)currentSelectedView).index];
			}
		}
        currentSelectedView = nil;
        [self cancelDeleteAnimation];
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];

    if (!_bCanMoveCell)
        return;
    
	UITouch *touch = [touches anyObject];
	UIView *touchView = [touch view];
	CGPoint movedPoint = [touch locationInView:scrollView];
	if (m_bMoving) {
		CGPoint deltaVector = CGPointMake(movedPoint.x - lastTouchPoint.x, movedPoint.y - lastTouchPoint.y);
		lastTouchPoint = movedPoint;
		
		if ([touchView isKindOfClass:[SQGridCell class]]) {
			touchView.center = CGPointMake(touchView.center.x + deltaVector.x, touchView.center.y + deltaVector.y);
            // 检测是否可以移位
			if ([self exchangeViewsPosition:touchView]) {
                [self layoutItemViews];
            }
 		}
	} else {
		CGPoint deltaVector = CGPointMake(movedPoint.x - touchStartPoint.x, movedPoint.y - touchStartPoint.y);
		
		if (fabsf(deltaVector.x) > TOUCH_MOVE_EFFECT_DIST
			|| fabsf(deltaVector.y) > TOUCH_MOVE_EFFECT_DIST) {
			[self stopTouchTimer];
            [self cancelDeleteAnimation];
		}
	}
}

#pragma mark - animations

// 视图放大动画
- (void)scaleAnimationWithView:(UIView*)view
{		
#if SCALE_ANIMATION
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.3];
	view.transform = CGAffineTransformMakeScale(1.2, 1.2);
	[UIView commitAnimations];
#endif
}

- (void)removeAnimationWithView:(UIView*)view
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationCurve: UIViewAnimationCurveLinear];
	view.transform = CGAffineTransformIdentity;
	[UIView commitAnimations];
}

- (void)layCurrentView
{
    CGPoint centerPoint = [self getCenterPointWithIndex:currentSelectedView.tag];
    // 添加一个动画
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [currentSelectedView setCenter:centerPoint];
    [UIView commitAnimations];
}

// 取消动画
- (void)cancelDeleteAnimation
{
	for (UIView *view in m_allBookCells) {
		[self removeAnimationWithView:view];
	}
	
	m_bMoving = NO;
    // touch结束后使其能滑动
    scrollView.scrollEnabled = YES;
    if (currentSelectedView != nil)
        [self layCurrentView];
}

@end
