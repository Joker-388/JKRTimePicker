//
//  TimeView.h
//  TimeSelectViewDemo
//
//  Created by tronsis_ios on 16/8/16.
//  Copyright © 2016年 tronsis_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimeViewDelegate <NSObject>

@required
- (void)timeViewDidChangeTime;

@end

@interface TimeView : UIView

- (instancetype)initWithFrame:(CGRect)frame availableArray:(NSArray<NSNumber *> *)availableArray;
- (void)setSelectedStartTime:(NSInteger)startTime endTime:(NSInteger)endTime;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy, readonly) NSString *startTime;
@property (nonatomic, copy, readonly) NSString *endTime;
@property (nonatomic, assign) NSInteger totalTimes;
@property (nonatomic, weak) id<TimeViewDelegate> delegate;

@end
