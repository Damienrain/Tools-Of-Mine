//
//  NSTimer+Addition.h
//  CycleScrollView
//
//  Created by 左建军 on 15/10/2.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)

// 暂停
- (void)pauseTimer;
// 继续
- (void)resumeTimer;
// 在多少秒以后继续
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
