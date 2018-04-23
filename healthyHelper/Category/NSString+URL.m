//
//  NSString+URL.m
//  图书管理
//
//  Created by snow on 2017/5/18.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)
+(NSString *)urlStringWithpath:(NSString *)path paramas:(NSDictionary *)paramas{
    NSMutableString *str = @"";
    if (paramas) {
        [paramas enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [str appendFormat:@"/%@",obj];
        }];
    }

    return str;
}
@end
