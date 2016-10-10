//
//  LSUploadRequestOperation.h
//  Pods
//
//  Created by ThoamsTan on 16/9/20.
//
//

#import <Foundation/Foundation.h>
typedef void(^UPLOAD_SUCCESS)(NSDictionary *responseObject);
typedef void(^UPLOAD_FAILURE)(NSError *error);
@interface LSUploadRequestOperation : NSOperation
@property(nonatomic, strong)UPLOAD_SUCCESS success;
@property(nonatomic, strong)UPLOAD_FAILURE failure;
@property(nonatomic, copy)NSString *strURL;
@property(nonatomic, strong)NSString *fileName;
@property(nonatomic, strong)NSData *postData;
@property(nonatomic, strong)NSString *contentType;
@property(nonatomic, strong)NSDictionary *headField;
@end
