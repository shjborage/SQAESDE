//
//  ViewController.m
//  test_SQGridView
//
//  Created by Shi Eric on 7/11/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import "ViewController.h"
#import "SQLibs.h"
#import "testGridCell.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize vSQGrid = _vSQGrid;

@synthesize arTest = _arTest;

- (void)dealloc
{
    [_vSQGrid release];
    
    [_arTest release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initDataSource];
    [self initSQGridView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - view orientation

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self reloadView:toInterfaceOrientation];
}

- (void)reloadView:(UIInterfaceOrientation)orientation
{
    _vSQGrid.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);    
    [_vSQGrid reload:NO];    
}


#pragma mark - other init

- (void)initDataSource
{
    self.arTest = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        [_arTest addObject:[NSNumber numberWithInt:i]];
    }
}

- (void)initSQGridView
{
    if (_vSQGrid == nil)
        _vSQGrid = [[SQGridScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height - 44.0f)];
    else
        [_vSQGrid removeCacheCells];
    
    _vSQGrid.sdataSource = self;
    _vSQGrid.sdelegate = self;
    _vSQGrid.ScrollViewDelegate = self;
    _vSQGrid.Style = GRIDSCROLL_VERTICAL_STYLE;
    _vSQGrid.bounces = YES;
    _vSQGrid.pagingEnabled = NO;
    _vSQGrid.showsHorizontalScrollIndicator = NO;
    _vSQGrid.backgroundColor = [UIColor grayColor];
    
    [_vSQGrid reload:NO];
    
    if (_vSQGrid.superview == nil)
        [self.view addSubview:_vSQGrid];
}

#pragma mark - SQGridView DataSource

- (NSUInteger)gridViewNumberOfAllCells:(UIView *)gridView;
{
    return [_arTest count];
}

- (CGSize)gridViewCellSize:(UIView *)gridView
{
    return CGSizeMake(50.0f, 50.0f);
}

- (BOOL)gridViewCanMoveCell:(UIView *)gridView
{
    return YES;
}

- (NSUInteger)gridViewNumberOfColumns:(UIView *)gridView
{
    if (SQ_ISORIENTATION_LANDSCAPE) {
        return 4;
    } else {
        return 3;
    }
}

- (CGFloat)gridViewSizeOfRowInterval:(UIView *)gridView
{
    return 20.0f;
}

- (CGFloat)gridViewSizeOfColumnInterval:(UIView *)gridView
{
    if (SQ_ISORIENTATION_LANDSCAPE) {
        return 20.0f;
    } else {
        return 20.0f;
    }
}

- (SQGridCell *)gridView:(UIView *)gridView 
             visibleCell:(SQGridCell *)visibleCell 
                forIndex:(NSUInteger)uIndex
{
    if (visibleCell == nil) {
        visibleCell = [[[testGridCell alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, 50.0f)] autorelease];
    }
    
    [(testGridCell *)visibleCell setCellView:[_arTest objectAtIndex:uIndex]];
    
    return visibleCell;
}

/*  If you want custom the cells center, use this function
- (CGPoint)gridViewCellCenterPointWithIndex:(NSUInteger)uIndex
{
}
 */

/*  If you want custom the scrollView contentSize
- (CGSize)gridViewContentSizeAdapter
{
}
 */

#pragma mark - SQGridView delegate

- (void)gridView:(SQGridView *)gridView 
   didSelectCell:(SQGridCell *)cell 
         atIndex:(NSUInteger)index
{
    SQLOG(@"%@ index:%d", __FUNC_NAME__, index);
}

- (void)gridViewExchangeCell:(SQGridCell *)originCell 
                exchangeCell:(SQGridCell *)exchangeCell
{
    SQLOG(@"%@ index:%d exchage index:%d", __FUNC_NAME__, originCell.index, exchangeCell.index);
}


@end
