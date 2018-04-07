//
//  GetOneDay.m
//  healthyHelper
//
//  Created by snow on 2018/3/4.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "GetOneDay.h"

@implementation GetOneDay
// 获取几年几月的日期，0表示今天，负数表示之前
+(NSString *)getOneDay:(int)day{
    int year = 0,month = 0;
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calender components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSDateComponents *adcomps = [[NSDateComponents alloc]init];
    [adcomps setYear:year];
    [adcomps setMonth:month];
    [adcomps setDay:day];
    NSDate *newdate = [calender dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"M-dd"];
    NSString *dayStr = [formatter stringFromDate:newdate];
    return dayStr;
}
@end
