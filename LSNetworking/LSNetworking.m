//
//  LSNetworking.m
//  LSNetworking
//
//  Created by ThoamsTan on 16/8/1.
//  Copyright © 2016年 ThoamsTan. All rights reserved.
//

#import "LSNetworking.h"
#import "LSHttpRequestOperation.h"
#import "LSUploadRequestOperation.h"
@interface LSNetworking()
@property(nonatomic,strong)NSOperationQueue *queue;
@property (nonatomic,strong)NSDictionary *api;
@end
@implementation LSNetworking
static LSNetworking *instance = nil;
+ (id)sharedNetworking
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
- (void)get:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SUCCESS)success failure:(FAILURE)failure
{
    [self get:URLString parameters:parameters dotNet:NO success:success failure:failure];
}
- (void)post:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SUCCESS)success failure:(FAILURE)failure
{
    [self post:URLString parameters:parameters dotNet:NO success:success failure:failure];
}
- (void)get:(NSString *)URLString parameters:(NSDictionary *)parameters dotNet:(BOOL)dotNet success:(SUCCESS)success failure:(FAILURE)failure
{
    [self addRequestOperation:URLString method:@"GET" parameters:parameters dotNet:dotNet success:success failure:failure];
}
- (void)post:(NSString *)URLString parameters:(NSDictionary *)parameters dotNet:(BOOL)dotNet success:(SUCCESS)success failure:(FAILURE)failure
{
    [self addRequestOperation:URLString method:@"POST" parameters:parameters dotNet:dotNet success:success failure:failure];
}
- (void)addRequestOperation:(NSString *)URLString method:(NSString*)method parameters:(NSDictionary *)parameters dotNet:(BOOL)dotNet success:(SUCCESS)success failure:(FAILURE)failure
{
    LSHttpRequestOperation *requestOperation = [[LSHttpRequestOperation alloc] init];
    requestOperation.dotNet = dotNet;
    requestOperation.requestMethod = method;
    requestOperation.success = success;
    requestOperation.failure = failure;
    requestOperation.strURL = URLString;
    requestOperation.param = parameters;
    [self.queue addOperation:requestOperation];
}
- (void)upload:(NSString *)URLString headField:(NSDictionary *)headField postData:(NSData *)postData fileName:(NSString*)fileName contentType:(NSString*)contentType success:(SUCCESS)success failure:(FAILURE)failure
{
    LSUploadRequestOperation *requestOperation = [[LSUploadRequestOperation alloc] init];
    requestOperation.success = success;
    requestOperation.failure = failure;
    requestOperation.strURL = URLString;
    requestOperation.postData = postData;
    requestOperation.fileName = fileName;
    requestOperation.contentType = contentType;
    requestOperation.headField = headField;
    [self.queue addOperation:requestOperation];
}
@end