//
//  ViewController.h
//  test_SQGridView
//
//  Created by Shi Eric on 7/11/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLibs.h"

@interface ViewController : UIViewController
<
SQGridScrollViewDelegate,
SQGridViewDataSource,
SQGridViewDelegate
>
{
    SQGridScrollView *_vSQGrid;
    
    NSMutableArray *_arTest;
}

@property (nonatomic, retain) SQGridScrollView *vSQGrid;

@property (nonatomic, retain) NSMutableArray *arTest;

@end
