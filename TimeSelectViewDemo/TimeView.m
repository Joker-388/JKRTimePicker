//
//  TimeView.m
//  TimeSelectViewDemo
//
//  Created by tronsis_ios on 16/8/16.
//  Copyright © 2016年 tronsis_ios. All rights reserved.
//

#import "TimeView.h"
#import "TimeSelectedView.h"

@interface TimeView ()<TimeSelectedViewDelegate>

@property (nonatomic, strong) UILabel *dataView;
@property (nonatomic, strong) TimeSelectedView *selectedView;

@end

@implementation TimeView

- (instancetype)initWithFrame:(CGRect)frame availableArray:(NSArray<NSNumber *> *)availableArray {
    self = [self initWithFrame:frame];
    _dataView = [UILabel new];
    _dataView.frame = CGRectMake(0, 0, self.frame.size.width, 65);
    _dataView.textAlignment = NSTextAlignmentCenter;
    _dataView.font = [UIFont systemFontOfSize:13];
    _dataView.textColor = [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1.0];
    _selectedView = [[TimeSelectedView alloc] initWithFrame:CGRectMake(0, 65, self.frame.size.width, self.frame.size.height - 65) availableArray:availableArray];
    _selectedView.delegate = self;
    [self addSubview:_dataView];
    [self addSubview:_selectedView];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

- (void)setDate:(NSDate *)date {
    _date = date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *timeStr = [formatter stringFromDate:_date];
    _dataView.text = timeStr;
}

- (NSString *)startTime {
    if (!self.selectedView.selectedTimes.count) return @"还没有选择时间";
    NSArray<NSNumber *> *times = self.selectedView.selectedTimes;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *timeStr = [formatter stringFromDate:_date];
    NSMutableString *string = [NSMutableString stringWithString:timeStr];
    [string appendString:[NSString stringWithFormat:@" %02zd:00", [times[0] integerValue]]];
    return string;
}

- (NSString *)endTime {
    if (!self.selectedView.selectedTimes.count) return @"还没有选择时间";
    NSArray<NSNumber *> *times = self.selectedView.selectedTimes;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *timeStr = [formatter stringFromDate:_date];
    NSMutableString *string = [NSMutableString stringWithString:timeStr];
    [string appendString:[NSString stringWithFormat:@" %02zd:00", [times.lastObject integerValue]]];
    return string;
}

- (NSInteger)totalTimes {
    if (!self.selectedView.selectedTimes.count) return 0;
    return abs((int)([self.selectedView.selectedTimes.firstObject integerValue] - [self.selectedView.selectedTimes.lastObject integerValue])) + 1;
}

- (void)timeSelectedViewDidChangeTime {
    if ([self.delegate respondsToSelector:@selector(timeViewDidChangeTime)]) {
        [self.delegate timeViewDidChangeTime];
    }
}

- (void)setSelectedStartTime:(NSInteger)startTime endTime:(NSInteger)endTime {
    [self.selectedView setSelectedStartTime:startTime endTime:endTime];
}

@end
