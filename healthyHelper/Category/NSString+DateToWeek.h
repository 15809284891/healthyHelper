//
//  NSString+DateToWeek.h
//  healthyHelper
//
//  Created by snow on 2018/1/11.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DateToWeek)
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
@end
