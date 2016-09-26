//
//  LSHttpRequestOperation.h
//  Pods
//
//  Created by ThoamsTan on 16/8/17.
//
//

#import <Foundation/Foundation.h>
typedef void(^SUCCESS)(NSDictionary *responseObject);
typedef void(^FAILURE)(NSError *error);

@interface LSHttpRequestOperation : NSOperation
@property(nonatomic, copy)NSString *requestMethod;
@property(nonatomic, strong)SUCCESS success;
@property(nonatomic, strong)FAILURE failure;
@property(nonatomic, copy)NSString *strURL;
@property(nonatomic, strong)NSDictionary *param;
//是否为.net接口，.net接口的处理方式不一样，所以必须分开处理
//1.token放head里
//2.参数用json方式
@property (nonatomic, assign) BOOL dotNet;
@end
