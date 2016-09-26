//
//  LSUploadRequestOperation.m
//  Pods
//
//  Created by ThoamsTan on 16/9/20.
//
//

#import "LSUploadRequestOperation.h"
#define boundary @"440bf639-63ad-4528-931b-440a069d0484"
@implementation LSUploadRequestOperation
- (void)main
{
//    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.strURL]];
//    requestM.HTTPMethod = @"POST";
//    
//    // 设置请求头(告诉服务器,这是一个文件上传的请求)
//    [requestM setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
//    
//    // 设置请求体
//    NSMutableData *body = [NSMutableData data];
//    
//    // 文件参数
//    // 分割线
//    [body appendData:[@"--" dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[boundary dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    // 文件参数名
//    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"",self.fileName] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    // 文件的类型
//    [body appendData:[[NSString stringWithFormat:@"Content-Type: %@",self.contentType] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    // 文件数据
//    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:self.postData];
//    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    // 结束标记
//    /*
//     --分割线--\r\n
//     */
//    [body appendData:[@"--" dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:boundary];
//    [body appendData:[@"--" dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    [[session uploadTaskWithRequest:requestM
//                                fromData:body
//                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                           dispatch_async(dispatch_get_main_queue(), ^{
//                               if (error) {
//                                   self.failure(error);
//                               } else {
//                                   //解析数据
//                                   NSError *error;
//                                   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//                                   if (error) {
//                                       self.failure(error);
//                                   }else{
//                                       self.success(dic);
//                                   }
//                               }
//                           });
//                           
//                       }]
//     resume];
}
@end
