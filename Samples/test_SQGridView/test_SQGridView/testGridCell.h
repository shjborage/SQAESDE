//
//  testGridCell.h
//  test_SQGridView
//
//  Created by Shi Eric on 7/12/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import "SQGridCell.h"

@interface testGridCell : SQGridCell
{
    UILabel *_lbTitle;
}

@property (nonatomic, retain) UILabel *lbTitle;

- (void)setCellView:(id)data;

@end
