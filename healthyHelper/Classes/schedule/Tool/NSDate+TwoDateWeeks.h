//
//  NSDate+TwoDateWeeks.h
//  healthyHelper
//
//  Created by snow on 2018/3/4.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TwoDateWeeks)
+(NSInteger)currentWeekFromBegin:(NSString *)beginDateStr;
+ (NSInteger) getAllWeeks:(NSString *)beginDateStr end:(NSString *)endDateStr;
@end
