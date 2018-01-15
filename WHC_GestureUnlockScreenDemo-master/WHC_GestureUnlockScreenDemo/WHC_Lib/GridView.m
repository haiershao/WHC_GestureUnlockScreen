//
//  GridView.m
//  WHC_GestureUnlockScreenDemo
//
//  Created by jiyi on 2018/1/11.
//  Copyright © 2018年 吴海超. All rights reserved.
//

#import "GridView.h"

@implementation GridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor grayColor];
        //        self.lineColor = [UIColor colorWithRed:135.0f/255.0f green:120.0f/255.0f blue:121.0f/255.0f alpha:0.8f];
        self.lineColor = [UIColor blackColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    int countRow = self.frame.size.height/20;
    int countCla = self.frame.size.width/20;
    for (int i =0 ; i<countRow; i++) {
        CGContextMoveToPoint(context, 0, i*20);
        CGContextAddLineToPoint(context, self.bounds.size.width, i*20);
        
    }
    for (int i =0 ; i<countCla; i++) {
        CGContextMoveToPoint(context, i*20, 0);
        CGContextAddLineToPoint(context, i*20, self.bounds.size.height);
        
    }
    
    
    
//    CGContextMoveToPoint(context, self.bounds.size.width / 3, 0);
//    CGContextAddLineToPoint(context, self.bounds.size.width / 3, self.bounds.size.height);
    
//    CGContextMoveToPoint(context, self.bounds.size.width * 2 / 3, 0);
//    CGContextAddLineToPoint(context, self.bounds.size.width * 2 / 3, self.bounds.size.height);
//
//    CGContextMoveToPoint(context, 0, self.bounds.size.height / 3);
//    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height / 3);
//
//    CGContextMoveToPoint(context, 0, self.bounds.size.height * 2 / 3);
//    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height * 2 / 3);
    
    CGContextStrokePath(context);
    UIGraphicsEndImageContext();
}

@end
