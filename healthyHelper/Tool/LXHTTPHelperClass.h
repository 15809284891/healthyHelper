//
//  LXHTTPHelperClass.h
//  图书管理
//
//  Created by snow on 2017/5/8.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPSessionManager;
//typedef void (^DonloadBlockSuccess) (AFHTTPSessionManager *sessionManager,id responseObject);
@interface LXHTTPHelperClass : NSObject
+(LXHTTPHelperClass *)shareInstanse;
-(void)LXGET:(NSString *)URLString
                    parameters:(id)parameters
                       Value:(void (^)( id responseObject))LXValue
                       Error:(void (^)( NSError * error))LXError;
- (void)LXPOST:(NSString *)URLString
                    parameters:(id)parameters
                       Value:(void (^)(id responseObject))LXValue
                         Error:(void (^)(NSError * error))LXError;
@end
