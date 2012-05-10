//
//  SQBadgeView.h
//  iMagazine
//
//  Created by shjborage on 2/19/12.
//  Copyright (c) 2012 Safe&Quick[http://blog.sina.com.cn/shjborage] All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


@interface SQBadgeView : UIView
{
	NSUInteger width;
	NSString *badgeString;
	
	UIFont *font;
	UITableViewCell *parent;
	
	UIColor *badgeColor;
	UIColor *badgeColorHighlighted;		
}

@property (nonatomic, readonly) NSUInteger width;
@property (nonatomic, retain) NSString *badgeString;
@property (nonatomic, assign) UITableViewCell *parent;
@property (nonatomic, assign) BOOL shadowEnabled;
@property (nonatomic, retain) UIColor *badgeColor;
@property (nonatomic, retain) UIColor *badgeColorHighlighted;
@property (nonatomic, assign) id delegate;

- (void) drawRoundedRect:(CGRect) rrect 
               inContext:(CGContextRef) context 
			  withRadius:(CGFloat) radius;

@end
