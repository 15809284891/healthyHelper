//
//  NSString+LXExtension.m
//  图书管理
//
//  Created by snow on 2017/1/23.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "NSString+LXExtension.h"

@implementation NSString (LXExtension)
+(NSString *)stringWithFileSize:(unsigned long long)size{
    if (size== 0) {
        return @"没有缓存";
    }
    else if(size<1000){
        return [NSString stringWithFormat:@"%lluB",size];
    }
    else if(size<(1024*1024)){
        return [NSString stringWithFormat:@"%.2fKB",size/1024.0];
    }
    else if (size<(1024*1024*1024)){
        return [NSString stringWithFormat:@"%.2fMB",size/1024.0/1024.0];
    }
    else{
        return @"内存紧张";
    }
}
@end
