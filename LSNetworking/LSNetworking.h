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
+ (LSNetworking *)sharedNetworking;
- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SUCCESS)success failure:(FAILURE)failure;
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(SUCCESS)success failure:(FAILURE)failure;
@end