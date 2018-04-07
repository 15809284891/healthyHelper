//
//  NSDate+TwoDateWeeks.m
//  healthyHelper
//
//  Created by snow on 2018/3/4.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "NSDate+TwoDateWeeks.h"

@implementation NSDate (TwoDateWeeks)

+(NSInteger)getAllWeeks:(NSString *)beginDateStr end:(NSString *)endDateStr{
    NSInteger days =[self getAllDays:beginDateStr end:endDateStr];
    return days/7;
}
+(NSInteger)currentWeekFromBegin:(NSString *)beginDateStr{
    NSDate *nowDate = [NSDate date];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    
    dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss";//指定转date得日期格式化形式
    NSInteger days =[self getAllDays:beginDateStr end:[dateFormatter stringFromDate:nowDate]];
    if (days%7==0) {
        return days/7;
    }
    return days/7+1;
}
+(NSInteger)getAllDays:(NSString *)beginDateStr end:(NSString *)endDateStr{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *beginDate =[dateFormatter dateFromString:beginDateStr];
    NSDate *endDate = [dateFormatter dateFromString:endDateStr];
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[endDate timeIntervalSinceDate:beginDate];
    
    NSInteger days=((int)time)/(3600*24);
    //int hours=((int)time)%(3600*24)/3600;
    //NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    NSInteger allDays = days+1;
    return allDays;
}
@end
