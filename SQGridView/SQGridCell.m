//
//  SQGridCell.m
//  SQGridView
//
//  Created by Shi Eric on 3/2/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//


#import "SQGridCell.h"
#import "SQStringUtils.h"

@interface SQGridCell (private)

@end

@implementation SQGridCell

@synthesize delegate = _delegate;
@synthesize index = _index;

- (void)dealloc
{
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
