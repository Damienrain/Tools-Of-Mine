//
//  NSTimer+Addition.m
//  CycleScrollView
//
//  Created by 左建军 on 15/10/2.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import "NSTimer+Addition.h"

@implementation NSTimer (Addition)

-(void)pauseTimer
{
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate distantFuture]];
}

-(void)resumeTimer
{
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end
