//
//  TimeLabel.m
//  TimeSelectViewDemo
//
//  Created by tronsis_ios on 16/8/16.
//  Copyright © 2016年 tronsis_ios. All rights reserved.
//

#import "TimeLabel.h"

@implementation TimeLabel

- (void)setType:(NSInteger)type {
    _type = type;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    UIColor *fillColor = [UIColor colorWithRed:12/255.0 green:197/255.0 blue:181/255.0 alpha:1.0];
    if(_type == 0) {
        self.textColor = _available ? [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1.0] : [UIColor lightGrayColor];
    } else if (_type == 1) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGPoint center = CGPointMake(self.frame.size.height * 0.3, self.frame.size.height * 0.5);
        CGFloat radius = self.frame.size.height * 0.3;
        CGFloat startA = M_PI_2;
        CGFloat endA = M_PI_2 * 3;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        [path addLineToPoint:CGPointMake(self.frame.size.width * 0.7, path.currentPoint.y)];
        CGPoint rightCenter = CGPointMake(self.frame.size.width - self.frame.size.height * 0.3, self.frame.size.height * 0.5);
        CGFloat rightStartA = -M_PI_2;
        CGFloat rightEndA = M_PI_2;
        [path addArcWithCenter:rightCenter radius:radius startAngle:rightStartA endAngle:rightEndA clockwise:YES];
        [fillColor setFill];
        CGContextAddPath(context, path.CGPath);
        CGContextFillPath(context);
        self.textColor = [UIColor whiteColor];
    } else if (_type == 2) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGPoint center = CGPointMake(self.frame.size.height * 0.3, self.frame.size.height * 0.5);
        CGFloat radius = self.frame.size.height * 0.3;
        CGFloat startA = M_PI_2;
        CGFloat endA = M_PI_2 * 3;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        [path addLineToPoint:CGPointMake(self.frame.size.width, path.currentPoint.y)];
        [path addLineToPoint:CGPointMake(path.currentPoint.x, self.frame.size.height - self.frame.size.height * 0.2)];
        [fillColor setFill];
        CGContextAddPath(context, path.CGPath);
        CGContextFillPath(context);
        self.textColor = [UIColor whiteColor];
    } else if (_type == 3) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGPoint rightCenter = CGPointMake(self.frame.size.width - self.frame.size.height * 0.3, self.frame.size.height * 0.5);
        CGFloat radius = self.frame.size.height * 0.3;
        CGFloat rightStartA = -M_PI_2;
        CGFloat rightEndA = M_PI_2;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:rightCenter radius:radius startAngle:rightStartA endAngle:rightEndA clockwise:YES];
        [path addLineToPoint:CGPointMake(0, path.currentPoint.y)];
        [path addLineToPoint:CGPointMake(path.currentPoint.x, self.frame.size.height * 0.2)];
        [fillColor setFill];
        CGContextAddPath(context, path.CGPath);
        CGContextFillPath(context);
        self.textColor = [UIColor whiteColor];
    } else if (_type == 4) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, self.frame.size.height * 0.2, self.frame.size.width, self.frame.size.height * 0.6)];
        [fillColor setFill];
        CGContextAddPath(context, path.CGPath);
        CGContextFillPath(context);
        self.textColor = [UIColor whiteColor];
    }
    
    [super drawRect:rect];
}

@end
