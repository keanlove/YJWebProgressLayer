//
//  YJWebProgressLayer.m
//  YJWebProgressLayer
//
//  Created by Kean on 2016/12/15.
//  Copyright © 2016年 Kean. All rights reserved.
//

#import "YJWebProgressLayer.h"
#import "NSTimer+addition.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

static NSTimeInterval const kFastTimeInterval = 0.03;


@interface YJWebProgressLayer ()

@property (nonatomic, strong) CAShapeLayer *layer;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat plusWidth;  // 线条分为无数个点，线条的增加点的宽度

@end

@implementation YJWebProgressLayer

- (instancetype)init {
    
    if (self = [super init]) {
        [self initialize];
    }
    
    return self;
    
}

- (void)dealloc {
    
    [self closeTimer];
    
}

- (void)initialize {
    
    // 绘制贝赛尔曲线
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 3)];                // 起点
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH, 3)];  // 终点
    
    self.path = path.CGPath;
    self.strokeEnd = 0;
    _plusWidth = 0.005;
    
    self.lineWidth = 2;
    self.strokeColor = [UIColor orangeColor].CGColor;    // 设置进度条的颜色
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:kFastTimeInterval target:self selector:@selector(pathChanged:) userInfo:nil repeats:YES];
    [_timer pauseTime];
    
}

// 设置进度条增加的进度
- (void)pathChanged:(NSTimer *)timer {
    
    self.strokeEnd += _plusWidth;
    
    if (self.strokeEnd > 0.60) {
        _plusWidth = 0.002;
    }
    
    if (self.strokeEnd > 0.85) {
        _plusWidth = 0.0007;
    }
    
    if (self.strokeEnd > 0.93) {
        _plusWidth = 0;
    }
    
}

// 使用的是 WKWebView 在用KVO计算实际的读取进度时，调用该方法
- (void)wkWebViewPathChanged:(CGFloat)estimatedProgress {
    
    self.strokeEnd = estimatedProgress;
    
}

- (void)startLoad {
    
    [_timer webPageTimeWithTimeInterval:kFastTimeInterval];
    
}

- (void)finishedLoadWithError:(NSError *)error {
    
    CGFloat timer;
    
    if (error == nil) {
        [self closeTimer];
        timer = 0.5;
        self.strokeEnd = 1.0;
    }else {
        timer = 45.0;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timer * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (timer == 45.0) [self closeTimer];
        self.hidden = YES;
        [self removeFromSuperlayer];
    });
    
}

#pragma mark - private
- (void)closeTimer {
    
    [_timer invalidate];
    _timer = nil;
    
}
@end
