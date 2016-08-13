//
//  HttpRequest_OS.h
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/3/4.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global_Variable.h"

@interface HttpRequest_OS : NSObject

/**
 * 同步请求
 * dataType 请求服务器发送的数据格式
 * requestUrl 请求的路径
 */
-(void)synchronousRequestWithuserName:(NSString *)userName
                           requestUrl:(NSURL*)requestUrl
                           requestStr:(NSString*)requestStr
                    completionHandler:(nullable void (^)(NSURLResponse *, id _Nullable, NSError * _Nullable))completionHandler;

@end
