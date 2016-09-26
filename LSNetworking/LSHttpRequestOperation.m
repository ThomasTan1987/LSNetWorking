//
//  LSHttpRequestOperation.m
//  Pods
//
//  Created by ThoamsTan on 16/8/17.
//
//

#import "LSHttpRequestOperation.h"
@interface LSHttpRequestOperation()
@end
@implementation LSHttpRequestOperation
- (void)main
{
    NSString *finalURLString;
    if ([self.strURL hasPrefix:@"http://"]) {
        finalURLString = self.strURL;
    }else{
        finalURLString = [NSString stringWithFormat:@"http://%@",self.strURL];
    }
    
    if (![finalURLString hasSuffix:@"?"]) {
        finalURLString = [NSString stringWithFormat:@"%@?",finalURLString];
    }
    //
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //
    if ([self.requestMethod isEqualToString:@"GET"]) {
        //拼接参数
        NSMutableString *parametersString = [NSMutableString stringWithFormat:@"%@",finalURLString];
        for (int i=0; i<self.param.allKeys.count; i++) {
            NSString *key = self.param.allKeys[i];
            NSString *value = self.param[key];
            if (i == 0) {
                [parametersString appendFormat:@"%@=%@",key,value];
            }else{
                [parametersString appendFormat:@"&%@=%@",key,value];
            }
        }
        request.URL = [NSURL URLWithString:parametersString];
        request.HTTPMethod = self.requestMethod;
    } else if ([self.requestMethod isEqualToString:@"POST"]) {
        request.URL = [NSURL URLWithString:finalURLString];
        request.HTTPMethod = self.requestMethod;
        
        if (self.dotNet) {
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            if (self.param[@"token"]) {
                [request setValue:self.param[@"token"] forHTTPHeaderField:@"token"];
            }
            NSError *error;
            NSData *data = [NSJSONSerialization dataWithJSONObject:self.param options:0 error:&error];
            if (data) {
                request.HTTPBody = data;
            } else {
                return;
            }
        } else {
            NSMutableString *parametersString = [[NSMutableString alloc] init];
            for (int i=0; i<self.param.allKeys.count; i++) {
                NSString *key = self.param.allKeys[i];
                NSString *value = self.param[key];
                if (i == 0) {
                    [parametersString appendFormat:@"%@=%@",key,value];
                }else{
                    [parametersString appendFormat:@"&%@=%@",key,value];
                }
            }
            request.HTTPBody = [parametersString dataUsingEncoding:NSUTF8StringEncoding];
        }
    }
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                self.failure(error);
            } else {
                //解析数据
                NSError *error;
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                if (error) {
                    self.failure(error);
                }else{
                    self.success(dic);
                }
            }
        });
    }] resume];
}

@end
