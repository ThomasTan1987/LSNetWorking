//
//  LSNetworking.m
//  LSNetworking
//
//  Created by ThoamsTan on 16/8/1.
//  Copyright © 2016年 ThoamsTan. All rights reserved.
//

#import "LSNetworking.h"
#import "LSHttpRequestOperation.h"
@interface LSNetworking()
@property(nonatomic,strong)NSOperationQueue *queue;
@end
@implementation LSNetworking
static LSNetworking *instance = nil;
+ (LSNetworking* )sharedNetworking
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return self;
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
    LSHttpRequestOperation *requestOperation = [[LSHttpRequestOperation alloc] init];
    requestOperation.requestMethod = @"GET";
    requestOperation.success = success;
    requestOperation.failure = failure;
    requestOperation.strURL = URLString;
    requestOperation.param = parameters;
    [self.queue addOperation:requestOperation];
    
}
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SUCCESS)success failure:(FAILURE)failure
{
    LSHttpRequestOperation *requestOperation = [[LSHttpRequestOperation alloc] init];
    requestOperation.requestMethod = @"POST";
    requestOperation.success = success;
    requestOperation.failure = failure;
    requestOperation.strURL = URLString;
    requestOperation.param = parameters;
    [self.queue addOperation:requestOperation];
}
@end