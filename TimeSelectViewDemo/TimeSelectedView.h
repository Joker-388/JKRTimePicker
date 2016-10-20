//
//  TimeSelectedView.h
//  TimeSelectViewDemo
//
//  Created by tronsis_ios on 16/8/16.
//  Copyright © 2016年 tronsis_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TimeSelectedViewDelegate <NSObject>

@required
- (void)timeSelectedViewDidChangeTime;

@end

@interface TimeSelectedView : UIView

- (instancetype)initWithFrame:(CGRect)frame availableArray:(NSArray<NSNumber *> *)availableArray;
- (NSArray<NSNumber *> *)selectedTimes; ///< 选中的时间数组

@property (nonatomic, assign) BOOL singleSelected; ///<是否只允许单选
@property (nonatomic, weak) id<TimeSelectedViewDelegate> delegate;

- (void)setSelectedStartTime:(NSInteger)startTime endTime:(NSInteger)endTime;

@end

NS_ASSUME_NONNULL_END
