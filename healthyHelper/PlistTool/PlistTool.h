//
//  PlistTool.h
//  healthyHelper
//
//  Created by snow on 2018/1/13.
//  Copyright © 2018年 snow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistTool : NSObject
+(NSArray *)getPlistDataWithName:(NSString *)plistN;
+(NSDictionary *)getPlistDataDicWithName:(NSString *)plistN;
+(void)addDataInPlist:(NSString *)plistN withData:(NSMutableDictionary *)dataDic;
+(void)deleteDataInPlist:(NSString *)plistN byID:(NSString *)dataID;
+(void)upDateDataInPlist:(NSString *)plistN withData:(NSString *)dataID withData:(NSDictionary *)dataDic;
+(BOOL)searchDataFromPlist:(NSString *)plistN withData:(NSString *)dateID;
@end
