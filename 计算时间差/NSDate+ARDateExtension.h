//
//  NSDate+ARDateExtension.h
//  FlowerRainGround
//
//  Created by 阿仁欧巴 on 16/4/24.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ARDateExtension)

/**
 * 比较from 和 self 的时间差
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
    判断是否是今年
 */
- (BOOL)isThisYear;

/**
 *判断是否是今天
 */
- (BOOL)isThisToday;

/**
 *判断是否是昨天
 */
- (BOOL)isYestoday;


@end
