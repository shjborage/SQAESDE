//
//  SQGridCell.h
//  SQGridView
//
//  Created by Shi Eric on 3/2/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SQCellDelegate
@end

@interface SQGridCell : UIView
{
    id<SQCellDelegate> _delegate;
    
    NSUInteger _index;
}

@property (nonatomic, assign) id<SQCellDelegate> delegate;

@property (nonatomic, assign) NSUInteger index;

@end
