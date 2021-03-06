//
//  UIView+NHExtension.m
//  NHAutoCompleteTextBox
//
//  Created by Shahan on 14/12/2014.
//  Copyright (c) 2014 Shahan. All rights reserved.
//

#import "UIView+NHExtension.h"

@implementation UIView (NHExtension)

-(void)setYNextToView:(UIView *)refView
{
    [self setFrame:CGRectMake(self.frame.origin.x, refView.frame.origin.y + refView.frame.size.height, self.frame.size.width, self.frame.size.height)];
}

-(void)setY:(CGFloat)y
{
    [self setFrame:CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height)];
}

-(void)setHeight:(CGFloat)height
{
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height)];
}

-(void)setWidth:(CGFloat)width
{
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height)];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com