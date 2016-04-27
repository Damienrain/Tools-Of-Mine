//
//  NSDate+ARDateExtension.m
//  FlowerRainGround
//
//  Created by 阿仁欧巴 on 16/4/24.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "NSDate+ARDateExtension.h"

@implementation NSDate (ARDateExtension)

/**
 * 比较self 和 from 的时间
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from
{
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmpt = [calendar components:unit fromDate:from toDate:self options:0];

    return cmpt;

}


- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear = selfYear;
}

- (BOOL)isThisToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unite = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *nowCmpts = [calendar components:unite fromDate:[NSDate date]];
    NSDateComponents *selfCmpt = [calendar components:unite fromDate:self];
    return nowCmpts.year == selfCmpt.year
            && nowCmpts.month == selfCmpt.month
            && nowCmpts.day == selfCmpt.day;
}

- (BOOL)isYestoday
{
    //日期格式化类
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSDate *selfDate = [formatter dateFromString:[formatter stringFromDate:self]]; //self 表示的是调用当前方法的对象
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *compt = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
//时间差是一天
    return compt.year == 0 && compt.month == 0 && compt.day == 1;
    
}
























@end
