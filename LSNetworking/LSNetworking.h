//
//  LSNetworking.h
//  LSNetworking
//
//  Created by ThoamsTan on 16/8/1.
//  Copyright © 2016年 ThoamsTan. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUCCESS)(NSDictionary *responseDictionary);
typedef void(^FAILURE)(NSError *error);
@interface LSNetworking : NSObject
+ (id)sharedNetworking;
- (void)get:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SUCCESS)success failure:(FAILURE)failure;
- (void)post:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SUCCESS)success failure:(FAILURE)failure;
- (void)get:(NSString *)URLString parameters:(NSDictionary *)parameters dotNet:(BOOL)dotNet success:(SUCCESS)success failure:(FAILURE)failure;
- (void)post:(NSString *)URLString parameters:(NSDictionary *)parameters dotNet:(BOOL)dotNet success:(SUCCESS)success failure:(FAILURE)failure;
- (void)upload:(NSString *)URLString postData:(NSData *)postData fileName:(NSString*)fileName contentType:(NSString*)contentType success:(SUCCESS)success failure:(FAILURE)failure;
@end