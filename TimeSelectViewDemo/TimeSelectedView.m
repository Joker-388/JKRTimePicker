//
//  TimeSelectedView.m
//  TimeSelectViewDemo
//
//  Created by tronsis_ios on 16/8/16.
//  Copyright © 2016年 tronsis_ios. All rights reserved.
//

#import "TimeSelectedView.h"
#import "TimeLabel.h"

@interface TimeSelectedView ()

@property (nonatomic, strong) NSArray<NSNumber *> *availableArray;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *unAvailableArray;
@property (nonatomic, strong) NSMutableArray<TimeLabel *> *timeLabels;
@property (nonatomic, assign) NSInteger startIndex;
@property (nonatomic, assign) NSInteger endIndex;
@property (nonatomic, assign) NSInteger lastIndex;

@end

@implementation TimeSelectedView

- (instancetype)initWithFrame:(CGRect)frame availableArray:(NSArray<NSNumber *> *)availableArray {
    self = [self initWithFrame:frame];
    
    _availableArray = availableArray;
    _unAvailableArray = [NSMutableArray array];
    _timeLabels = [NSMutableArray array];
    _startIndex = -1;
    _endIndex = -1;
    _lastIndex = -1;
    
    int maxH = 6;
    int maxV = 4;
    CGFloat margin = 15;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = (self.frame.size.width - margin * 2) / maxH;
    CGFloat h = self.frame.size.height / maxV;
    NSDictionary *timeAttr = @{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor blackColor]};
    NSString *timeStr = nil;
    for (int index = 0; index < 24; index++) {
        x = margin + (index % maxH) * w;
        y = index / maxH * h;
        timeStr = [NSString stringWithFormat:@"%d时", index + 1];
        NSAttributedString *timeAttrStr = [[NSAttributedString alloc] initWithString:timeStr attributes:timeAttr];
        TimeLabel *label = [TimeLabel new];
        if ([self isAvailableLabeWithIndex:index]) {
            label.available = YES;
        } else {
            [self.unAvailableArray addObject:[NSNumber numberWithInteger:index]];
            label.available = NO;
        }
        label.attributedText = timeAttrStr;
        label.frame = CGRectMake(x, y, w, h);
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [_timeLabels addObject:label];
    }
    for (int i = 0; i < 5; i++) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(margin, i * h)];
        [path addLineToPoint:CGPointMake(self.frame.size.width, i * h)];
        path.lineWidth = 0.5;
        [path closePath];
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.strokeColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0].CGColor;
        layer.path = path.CGPath;
        [self.layer addSublayer:layer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

- (void)drawRect:(CGRect)rect {
    if ([self.delegate respondsToSelector:@selector(timeSelectedViewDidChangeTime)]) {
        [self.delegate timeSelectedViewDidChangeTime];
    }
    [self.timeLabels enumerateObjectsUsingBlock:^(TimeLabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.type = 0;
    }];
    if (_startIndex == -1 || _endIndex == -1) {
        return;
    }
    for (NSInteger i = _startIndex; i <= _endIndex; i++) {
        NSInteger type = 0;
        if (i == _startIndex && i ==_endIndex) {
            type = 1;
        } else
        if (i == _startIndex) {
            type = 2;
        } else
        if (i == _endIndex) {
            type = 3;
        } else
        if (i != _startIndex && i != _endIndex) {
            type = 4;
        }
        self.timeLabels[i].type = type;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint startPoint = [self getCurrentPoint:touches];
    TimeLabel *label = [self getCurrentLabelWithPoint:startPoint];
    if (!label || !label.available) return;
    NSInteger touchIndex = [self.timeLabels indexOfObject:label];
    
    if (touchIndex > _endIndex) {
        if ([self isHasUnAvailableFrom:_endIndex to:touchIndex]) {
            _startIndex = -1;
            _endIndex = -1;
            _lastIndex = -1;
        }
    }
    if (touchIndex < _startIndex) {
        if ([self isHasUnAvailableFrom:touchIndex to:_startIndex]) {
            _startIndex = -1;
            _endIndex = -1;
            _lastIndex = -1;
        }
    }
    
    if (_startIndex == -1 && _endIndex == -1) {
        _startIndex = _endIndex = touchIndex;
    } else if (_startIndex == _endIndex) {
        if (touchIndex == _startIndex) {
            _startIndex = -1;
            _endIndex = -1;
        } else if (touchIndex > _startIndex) {
            _endIndex = touchIndex;
        } else {
            _startIndex = touchIndex;
        }
    } else if (touchIndex >= _startIndex) {
        if (touchIndex == _endIndex) {
            _endIndex -= 1;
        } else {
            _endIndex = touchIndex;
        }
    } else if (touchIndex < _startIndex) {
//        _endIndex = _startIndex;
        _startIndex = touchIndex;
    }
    _lastIndex = touchIndex;
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint movePoint = [self getCurrentPoint:touches];
    TimeLabel *label = [self getCurrentLabelWithPoint:movePoint];
    if (!label || !label.available) return;
    NSInteger touchIndex = [self.timeLabels indexOfObject:label];
    if (_lastIndex == touchIndex) return;
    
    if (touchIndex > _endIndex) {
        if ([self isHasUnAvailableFrom:_endIndex to:touchIndex]) {
            _startIndex = -1;
            _endIndex = -1;
            _lastIndex = -1;
        }
    }
    if (touchIndex < _startIndex) {
        if ([self isHasUnAvailableFrom:touchIndex to:_startIndex]) {
            _startIndex = -1;
            _endIndex = -1;
            _lastIndex = -1;
        }
    }
    if (_startIndex == -1 && _endIndex == -1) {
        _startIndex = _endIndex = touchIndex;
    } else if (_startIndex == _endIndex) {
        if (touchIndex == _startIndex) {
            _startIndex = -1;
            _endIndex = -1;
        } else if (touchIndex > _startIndex) {
            _endIndex = touchIndex;
        } else {
            _startIndex = touchIndex;
        }
    } else if (touchIndex >= _startIndex) {
        if (touchIndex == _endIndex) {
            _endIndex -= 1;
        } else {
            _endIndex = touchIndex;
        }
    } else if (touchIndex < _startIndex) {
//        _endIndex = _startIndex;
        _startIndex = touchIndex;
    }
    _lastIndex = touchIndex;
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (CGPoint)getCurrentPoint:(NSSet *)touches {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    return point;
}

- (__kindof UILabel *)getCurrentLabelWithPoint:(CGPoint)point {
    for (UILabel *label in self.timeLabels) {
        if (CGRectContainsPoint(label.frame, point)) {
            return label;
        }
    }
    return nil;
}

- (BOOL)isAvailableLabeWithIndex:(NSInteger)index {
    for (NSNumber *number in self.availableArray) {
        if (([number integerValue] - 1) == index) return YES;
    }
    return NO;
}

- (BOOL)isHasUnAvailableFrom:(NSInteger)from to:(NSInteger)to {
    BOOL result = NO;
    for (NSInteger i = from; i < to; i++) {
        for (NSNumber *number in self.unAvailableArray) {
            if (([number integerValue] - 1) == i) return YES;
        }
    }
    if (_singleSelected) result = YES;
    return result;
}

- (NSArray<NSNumber *> *)selectedTimes {
    NSMutableArray *array = [NSMutableArray array];
    if (_startIndex == -1 || _endIndex == -1) {
        return [NSArray arrayWithArray:array];
    }
    for (NSInteger i = _startIndex; i <= _endIndex; i++) {
        [array addObject:[NSNumber numberWithInteger:i + 1]];
    }
    return [NSArray arrayWithArray:array];
}

- (void)setSelectedStartTime:(NSInteger)startTime endTime:(NSInteger)endTime {
    _startIndex = startTime;
    _endIndex = endTime;
    [self setNeedsDisplay];
}

@end
