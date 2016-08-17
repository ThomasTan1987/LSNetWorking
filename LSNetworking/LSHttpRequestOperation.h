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
@end
