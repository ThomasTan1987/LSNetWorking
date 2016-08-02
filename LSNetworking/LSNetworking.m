//
//  LSNetworking.m
//  LSNetworking
//
//  Created by ThoamsTan on 16/8/1.
//  Copyright © 2016年 ThoamsTan. All rights reserved.
//

#import "LSNetworking.h"
@interface LSNetworking()
@property (nonatomic, copy)SUCCESS success;
@property (nonatomic, copy)FAILURE failure;
@property (nonatomic, strong)NSMutableURLRequest *request;
@end
@implementation LSNetworking
static LSNetworking *instance = nil;
+ (LSNetworking* )sharedNetworking
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.request = [[NSMutableURLRequest alloc] init];
    });
    return instance;
}
+ (instancetype)alloc
{
    if (instance) {
        NSException *exception = [NSException exceptionWithName:NSInternalInconsistencyException reason:@"只能用sharedNetworking方法获取唯一对象" userInfo:nil];
        [exception raise];
    }
    return [super alloc];
}
#pragma mark - 
- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SUCCESS)success failure:(FAILURE)failure
{
    //
    [self request:URLString method:@"GET" parameters:parameters success:success failure:failure];
}
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SUCCESS)success failure:(FAILURE)failure
{
    [self request:URLString method:@"POST" parameters:parameters success:success failure:failure];
}
#pragma mark - private method
- (void)request:(NSString *)URLString method:(NSString *)method parameters:(NSDictionary *)parameters success:(SUCCESS)success failure:(FAILURE)failure
{
    NSString *finalURLString;
    if ([URLString hasPrefix:@"http://"]) {
        finalURLString = URLString;
    }else{
        finalURLString = [NSString stringWithFormat:@"http://%@",URLString];
    }
    
    if (![finalURLString hasSuffix:@"?"]) {
        finalURLString = [NSString stringWithFormat:@"%@?",finalURLString];
    }
    //
    self.success = success;
    self.failure = failure;
    //
    [self.request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //
    if ([method isEqualToString:@"GET"]) {
        //拼接参数
        NSMutableString *parametersString = [NSMutableString stringWithFormat:@"%@",finalURLString];
        for (int i=0; i<parameters.allKeys.count; i++) {
            NSString *key = parameters.allKeys[i];
            NSString *value = parameters[key];
            if (i == 1) {
                [parametersString appendFormat:@"%@=%@",key,value];
            }else{
                [parametersString appendFormat:@"&%@=%@",key,value];
            }
        }
        self.request.URL = [NSURL URLWithString:parametersString];
        self.request.HTTPMethod = method;
    } else if ([method isEqualToString:@"POST"]) {
        self.request.URL = [NSURL URLWithString:finalURLString];
        self.request.HTTPMethod = method;
    }
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:self.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //note:is not in main thread
        if (error) {
            self.failure(error);
        } else {
            //解析数据
            NSError *error;
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (error) {
                self.failure(error);
            }else{
                self.success(dic);
            }
        }
    }] resume];
}
@end