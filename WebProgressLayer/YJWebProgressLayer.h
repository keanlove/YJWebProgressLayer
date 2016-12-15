//
//  YJWebProgressLayer.h
//  YJWebProgressLayer
//
//  Created by Kean on 2016/12/15.
//  Copyright © 2016年 Kean. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface YJWebProgressLayer : CAShapeLayer

// 开始加载
- (void)startLoad;
// 完成加载
- (void)finishedLoadWithError:(NSError *)error;
// 关闭时间
- (void)closeTimer;

- (void)wkWebViewPathChanged:(CGFloat)estimatedProgress;

@end
