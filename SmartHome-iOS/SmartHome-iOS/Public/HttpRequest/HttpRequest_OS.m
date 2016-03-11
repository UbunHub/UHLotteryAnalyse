//
//  HttpRequest_OS.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/3/4.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "HttpRequest_OS.h"
#import "AFURLSessionManager.h"

@implementation HttpRequest_OS

/**
 * 同步请求
 * dataType 请求服务器发送的数据格式
 */
-(void)synchronousRequestWithuserName:(NSString *)userName
                           requestUrl:(NSURL*)requestUrl
                         requestStr:(NSString*)requestStr
                    completionHandler:(nullable void (^)(NSURLResponse *, id _Nullable, NSError * _Nullable))completionHandler{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"post"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:userName forHTTPHeaderField:@"userName"];
    [request setHTTPBody:[requestStr dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:completionHandler];
    [dataTask resume];
}

@end
