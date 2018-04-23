//
//  LXHTTPHelperClass.m
//  图书管理
//
//  Created by snow on 2017/5/8.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "LXHTTPHelperClass.h"
#import "AFNetworking.h"
@interface LXHTTPHelperClass()
{
    AFHTTPSessionManager *_manager;
}
@end
@implementation LXHTTPHelperClass
+(LXHTTPHelperClass *)shareInstanse{
    static LXHTTPHelperClass *_instanse;
    static dispatch_once_t _token;
    dispatch_once(&_token, ^{
        if (_instanse == nil) {
            _instanse = [[self alloc]init];
        }
    });
    return _instanse;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
//        _manager.requestSerializer.cachePolicy = NSURLCached

    }
    return self;
}
-(void)LXGET:(NSString *)URLString parameters:(id)parameters Value:(void (^)(id))LXValue Error:(void (^)(NSError *))LXError{

    [_manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        LXValue(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LXError(error);
    }];

}
-(void)LXPOST:(NSString *)URLString parameters:(id)parameters Value:(void (^)(id))LXValue Error:(void (^)(NSError *))LXError{
    NSLog(@"%@",parameters);
    [_manager  POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"%@",dic);
        LXValue(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LXError(error);
    }];
}

@end
