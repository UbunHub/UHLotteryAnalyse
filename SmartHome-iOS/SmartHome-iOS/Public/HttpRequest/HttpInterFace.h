//
//  HttpInterFace.h
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/3/10.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest_OS.h"

@protocol HttpInterFaceDelegate <NSObject>

-(void)httpInterFaceDataWithDic:(NSDictionary*)dataDic error:(NSError*)error;

@end

@interface HttpInterFace : NSObject

//请求数据类型
@property(assign, nonatomic) HTTPREQUEST_DATATYPE_INPUT inputDataType;

@property(weak, nonatomic) id<HttpInterFaceDelegate>delegate;

-(instancetype)initWithDelegate:(id<HttpInterFaceDelegate>)delegate;

/**
 * 登录
 * [in]userName 用户名
 * [in]passWord 密码
 */
-(void)logWithUserName:(NSString *)userName passWord:(NSString*)passWord;

/**
 * 注册
 * [in]tel 电话号码
 * [in]passWord 密码
 */
-(void)registerWithTelNO:(NSString*)tel passWord:(NSString*)passWord;

@end
