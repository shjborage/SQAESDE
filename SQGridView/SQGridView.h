//
//  VCGridView.h
//  SQGridView
//
//  Created by Shi Eric on 3/2/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQGridCell.h"

typedef enum _GridScrollViewStyle{
    GRIDSCROLL_HORIZONTAL_STYLE,
    GRIDSCROLL_VERTICAL_STYLE,
}GridScrollViewStyle;

@class SQGridView;
@class SQGridScrollView;

@protocol SQGridViewDelegate <NSObject>
@optional
- (void)gridView:(SQGridView *)gridView 
   didSelectCell:(SQGridCell *)cell
         atIndex:(NSUInteger)index;

- (void)gridViewExchangeCell:(SQGridCell *)originCell 
                exchangeCell:(SQGridCell *)exchangeCell;
@end

@protocol SQGridViewDataSource <NSObject>
@required
- (SQGridCell *)gridView:(UIView *)gridView 
             visibleCell:(SQGridCell *)visibleCell 
                forIndex:(NSUInteger)uIndex;

@optional
// GRIDSCROLL_HORIZONTAL_STYLE 水平滑动
- (NSUInteger)gridViewNumberOfRows:(UIView *)gridView;
- (CGFloat)gridViewSizeOfColumnInterval:(UIView *)gridView;

// GRIDSCROLL_VERTICAL_STYLE 竖直滑动
- (NSUInteger)gridViewNumberOfColumns:(UIView *)gridView;
- (CGFloat)gridViewSizeOfRowInterval:(UIView *)gridView;


@required
// 所有Cell数量，必需 根据Colums或者Rows，算出另外一个。
- (NSUInteger)gridViewNumberOfAllCells:(UIView *)gridView;
- (CGSize)gridViewCellSize:(UIView *)gridView;

- (BOOL)gridViewCanMoveCell:(UIView *)gridView;

@optional
- (CGPoint)gridViewCellCenterPointWithIndex:(NSUInteger)uIndex;
- (CGSize)gridViewContentSizeAdapter;

@end

@interface SQGridView : UIView 
<SQCellDelegate>
{
    NSMutableArray *m_allBookCells;
    UIImageView *_ivBackGroundView;
    UIScrollView *scrollView;
    
    GridScrollViewStyle _style;
    id<SQGridViewDelegate> _delegate;
    id<SQGridViewDataSource> _dataSource;
    
    BOOL bAnimated;
    BOOL bFirst;
    
    BOOL _bCanMoveCell;
    // for moving cell  and layout
    
    CGPoint touchStartPoint;			// 开始触摸位置
	CGPoint lastTouchPoint;				// 上次触摸位置
    
    UIView *currentSelectedView;		// 指向当前选中子视图
    
    BOOL m_bMoving;                     // 是否移动
    NSDate *touchStartTime;				// touch开始时间
    
    NSThread *timerThread;				// 时间线程
	NSTimer *touchTimer;				// 触摸定时器
    
    // 横竖版布局
	int rowCount;						// 一行视图个数
	int columnCount;					// 一列视图个数
	
	CGFloat rowIntervalSpace;			// 行间距
	CGFloat columnIntervalSpace;		// 列间距
}

@property (nonatomic, assign) id<SQGridViewDelegate> delegate;
@property (nonatomic, assign) id<SQGridViewDataSource> dataSource;
@property (nonatomic, assign) GridScrollViewStyle style;
@property (nonatomic, retain) UIImageView *ivBackGroundView;
@property (nonatomic, retain) NSMutableArray *m_allBookCells;
@property (nonatomic, assign) UIScrollView *scrollView;

@property BOOL bFirst;
@property BOOL bAnimated;

- (void)removeCellsArray:(NSUInteger)nIndex;
- (void)clearView;
- (void)removeCacheCells;

- (void)reload;
- (void)setbackGroundImage:(UIImage *)imgPortait imgLandscape:(UIImage *)imgLandscape;

@end
