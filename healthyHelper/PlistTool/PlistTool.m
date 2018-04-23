//
//  PlistTool.m
//  healthyHelper
//
//  Created by snow on 2018/1/13.
//  Copyright © 2018年 snow. All rights reserved.
//

#import "PlistTool.h"
@implementation PlistTool
+(NSDictionary *)getPlistDataDicWithName:(NSString *)plistN{
    NSMutableDictionary *plistDic = [NSMutableDictionary dictionary];
    //建立文件管理
    NSFileManager *fm = [NSFileManager defaultManager];
    //找到Documents 文件所在的路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //取得第一个 Documents 文件夹的路径
    NSString *filepath = [path objectAtIndex:0];
    //把要创建的 plist 文件加入
    NSString *plistPath = [filepath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",plistN]];
    NSLog(@"%@",plistPath);
    if ([fm fileExistsAtPath:plistPath] == NO) {
        NSLog(@"---------- 不存在");
        [fm createFileAtPath:plistPath contents:nil attributes:nil];
    }else{
        //         一、使用NSMutableArray来接收plist里面的文件，获取里面的数据
        plistDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        return plistDic;
        
    }
    return nil;
}
+(NSArray *)getPlistDataWithName:(NSString *)plistN{
    NSMutableArray *plistArr = [NSMutableArray array];
    //建立文件管理
    NSFileManager *fm = [NSFileManager defaultManager];
    //找到Documents 文件所在的路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //取得第一个 Documents 文件夹的路径
    NSString *filepath = [path objectAtIndex:0];
    //把要创建的 plist 文件加入
    NSString *plistPath = [filepath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",plistN]];
    NSLog(@"%@",plistPath);
    if ([fm fileExistsAtPath:plistPath] == NO) {
        NSLog(@"---------- 不存在");
        [fm createFileAtPath:plistPath contents:nil attributes:nil];
    }else{
//         一、使用NSMutableArray来接收plist里面的文件，获取里面的数据
    plistArr = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        return plistArr;
        
    }
    return nil;
}
+(void)addDataInPlist:(NSString *)plistN withData:(NSMutableDictionary *)dataDic{
    NSLog(@"dataDic  :%@",dataDic);
    //找到Documents 文件所在的路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //取得第一个 Documents 文件夹的路径
    NSString *filepath = [path objectAtIndex:0];
    NSString *plistPath = [filepath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",plistN]];
    NSMutableArray *plistArr = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    if (plistArr == nil) {
        plistArr = [[NSMutableArray alloc]init];
    }
    [plistArr addObject:dataDic];
    NSLog(@"要写入 plist 的数组 %@",plistArr);
    [plistArr writeToFile:plistPath atomically:YES];
}
+(void)upDateDataInPlist:(NSString *)plistN withData:(NSString *)dataID withData:(NSDictionary *)dataDic;{
    NSLog(@"dataDic  :%@",dataDic);
    //找到Documents 文件所在的路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //取得第一个 Documents 文件夹的路径
    NSString *filepath = [path objectAtIndex:0];
    NSString *plistPath = [filepath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",plistN]];
    NSMutableArray *plistArr = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
     NSArray * array = [NSArray arrayWithArray: plistArr];
    if ([plistN isEqualToString:@"course"]) {
        NSLog(@"找到了相符的");
        if (plistArr != nil) {
            NSLog(@"dataID : %@",dataID);
            for (NSDictionary *dic in array) {
                if ([dic[@"courseId"] isEqualToString:dataID]) {
                    NSLog(@"找到了对应的 id");
                    [plistArr removeObject:dic];
                }
            }
        }
    }
   
    [plistArr addObject:dataDic];
    NSLog(@"要写入 plist 的数组 %@",plistArr);
    [plistArr writeToFile:plistPath atomically:YES];
}
+(void)deleteDataInPlist:(NSString *)plistN byID:(NSString *)dataID{
    //找到Documents 文件所在的路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //取得第一个 Documents 文件夹的路径
    NSString *filepath = [path objectAtIndex:0];
    NSString *plistPath = [filepath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",plistN]];
    NSMutableArray *plistArr = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    NSArray * array = [NSArray arrayWithArray: plistArr];
    if ([plistN isEqualToString:@"course"]) {
        NSLog(@"找到了相符的");
        if (plistArr != nil) {
            NSLog(@"dataID : %@",dataID);
            for (NSDictionary *dic in array) {
                if ([dic[@"courseId"] isEqualToString:dataID]) {
                    NSLog(@"找到了对应的 id");
                    [plistArr removeObject:dic];
                }
            }
        }
    }
    
    [plistArr writeToFile:plistPath atomically:YES];
}
@end
