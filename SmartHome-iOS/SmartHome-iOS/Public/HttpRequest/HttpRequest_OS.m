//
//  HttpRequest_OS.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/3/4.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "HttpRequest_OS.h"
#import "NSDictionary+NSDictionaryCategory.h"
#import "AFURLSessionManager.h"

@implementation HttpRequest_OS

/**
 * 同步请求
 * dataType 请求服务器发送的数据格式
 */
-(void)synchronousRequestWithType:(HTTPREQUEST_DATATYPE_INPUT)dataType requestUrl:(NSURL*)requestUrl InputDataDic:(NSDictionary*)inputDataDic{
    
    NSString *jsonPostStr = [inputDataDic jsonStringWithPrettyPrint:NO];
    NSLog(@"jsonPostStr:%@",jsonPostStr);
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://127.0.0.1:8889/interface"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"post"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[jsonPostStr dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"response:%@ \n responseObject:%@", response, responseObject);
        }
    }];
    [dataTask resume];
}

@end
