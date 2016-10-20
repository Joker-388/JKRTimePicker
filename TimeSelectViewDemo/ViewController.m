//
//  ViewController.m
//  TimeSelectViewDemo
//
//  Created by tronsis_ios on 16/8/16.
//  Copyright © 2016年 tronsis_ios. All rights reserved.
//

#import "ViewController.h"
#import "TimeView.h"

@interface ViewController ()<TimeViewDelegate>

@property (nonatomic, strong) TimeView *timeView;
@property (nonatomic, strong) UILabel *show0;
@property (nonatomic, strong) UILabel *show1;
@property (nonatomic, strong) UILabel *show2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TimeView *timeView = [[TimeView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 300) availableArray:@[@1,@2,@3,@5,@6,@7,@8,@9,@10,@11,@12,@16,@17,@18,@19,@20]];
    [self.view addSubview:timeView];
    _timeView = timeView;
    _timeView.date = [NSDate date];
    _timeView.delegate = self;
    [_timeView setSelectedStartTime:17 endTime:19];
    _show0 = [UILabel new];
    _show0.frame = CGRectMake(50, CGRectGetMaxY(_timeView.frame) + 10, self.view.frame.size.width - 50, 50);
    _show0.numberOfLines = 1;
    [self.view addSubview:_show0];
    _show1 = [UILabel new];
    _show1.frame = CGRectMake(50, CGRectGetMaxY(_show0.frame), self.view.frame.size.width - 50, 50);
    _show1.numberOfLines = 1;
    [self.view addSubview:_show1];
    _show2 = [UILabel new];
    _show2.frame = CGRectMake(50, CGRectGetMaxY(_show1.frame), self.view.frame.size.width - 50, 50);
    _show2.numberOfLines = 1;
    [self.view addSubview:_show2];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"开始时间 %@", _timeView.startTime);
    NSLog(@"结束时间 %@", _timeView.endTime);
    NSLog(@"总共时长 %zd", _timeView.totalTimes);
}

- (void)timeViewDidChangeTime {
    _show0.text = [NSString stringWithFormat:@"startTime :%@", _timeView.startTime];
    _show1.text = [NSString stringWithFormat:@"endTime   : %@", _timeView.endTime];
    _show2.text = [NSString stringWithFormat:@"totalTime : %zd", _timeView.totalTimes];
}

@end
