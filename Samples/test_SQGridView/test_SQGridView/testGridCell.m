//
//  testGridCell.m
//  test_SQGridView
//
//  Created by Shi Eric on 7/12/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage]. All rights reserved.
//

#import "testGridCell.h"

@implementation testGridCell

@synthesize lbTitle = _lbTitle;

- (void)dealloc
{
    [_lbTitle release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initTitleLabel];
        self.backgroundColor = [UIColor darkGrayColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)initTitleLabel
{
    if (_lbTitle == nil)
        _lbTitle = [[UILabel alloc] initWithFrame:self.frame];
    
    _lbTitle.textAlignment = UITextAlignmentCenter;
    _lbTitle.backgroundColor = [UIColor clearColor];
    
    if (_lbTitle.superview == nil)
        [self addSubview:_lbTitle];
}

- (void)setCellView:(id)data
{
    _lbTitle.text = [NSString stringWithFormat:@"%d", [(NSNumber *)data intValue]];
}

@end
