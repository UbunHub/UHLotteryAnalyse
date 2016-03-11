//
//  HttpInterFace.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/3/10.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "HttpInterFace.h"
#import "NSDictionary+NSDictionaryCategory.h"


@implementation HttpInterFace

-(instancetype)initWithDelegate:(id<HttpInterFaceDelegate>)delegate{
    
    if (self == [super init]) {
        _delegate = delegate;
    }
    return self;
}

-(void)requestWithData:(id)data{
    
    NSString *requestStr;
    _inputDataType = (_inputDataType)?_inputDataType:DATATYPE_INPUT_JSON;
    HttpRequest_OS *http = [[HttpRequest_OS alloc]init];
    switch (_inputDataType) {
        case DATATYPE_INPUT_XML:
            requestStr = [data xmlStringWithStartElement:nil isFirstElement:NO];
            break;
        case DATATYPE_INPUT_JSON:
            requestStr = [data jsonStringWithPrettyPrint:YES];
        default:
            break;
    }
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8889/interface"];
    [http synchronousRequestWithuserName:@"" requestUrl:url requestStr:requestStr completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"response:%@ \n responseObject:%@", response, responseObject);
        }
        if ([_delegate respondsToSelector:@selector(httpInterFaceDataWithDic:error:)]) {
            [_delegate httpInterFaceDataWithDic:responseObject error:error];
        }
    }];
}
/**
 * 登录
 * [in]userName 用户名
 * [in]passWord 密码
 */
-(void)logWithUserName:(NSString *)userName passWord:(NSString*)passWord{
    
    NSDictionary *testDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             @"log",@"inefaceMode",
                             userName,@"userName",
                             passWord,@"passWord",
                             nil];
    [self requestWithData:testDic];
}

/**
 * 注册
 * [in]tel 电话号码
 * [in]passWord 密码
 */
-(void)registerWithTelNO:(NSString*)tel passWord:(NSString*)passWord{
    
    NSDictionary *testDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             @"register",@"inefaceMode",
                             tel,@"tel",
                             passWord,@"passWord",
                             nil];
    [self requestWithData:testDic];
    
    
}
@end
