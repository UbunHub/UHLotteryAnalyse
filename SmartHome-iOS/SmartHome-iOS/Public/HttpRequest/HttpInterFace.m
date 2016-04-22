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

-(void)requestWithData:(NSDictionary*)data{

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
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.27:8889/interface"];
    [http synchronousRequestWithuserName:@""
                              requestUrl:url
                              requestStr:requestStr
                       completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {


                           if ([_delegate respondsToSelector:@selector(httpInterFaceDataCode:DataDic:interFaceMode:)]) {
                               if (error ) {
                                   NSLog(@"%@",error);
                                   [_delegate httpInterFaceDataCode:error.code DataDic:[[NSDictionary alloc]initWithObjectsAndKeys:error.domain,@"result" ,nil] interFaceMode:[data objectForKey:@"inefaceMode"]];

                               } else if(!responseObject){

                                   [_delegate httpInterFaceDataCode:10001 DataDic:[[NSDictionary alloc]initWithObjectsAndKeys:@"返回数据为空",@"result" ,nil] interFaceMode:[data objectForKey:@"inefaceMode"]];
                               }else{

                                   NSDictionary *dic =(NSDictionary*)responseObject;

                                   NSLog(@"%@",dic);
                                   if ([[dic objectForKey:@"inforCode"] integerValue]!=0) {
                                       [_delegate httpInterFaceDataCode:[[dic objectForKey:@"inforCode"] integerValue]  DataDic:[dic objectForKey:@"inforMsg"] interFaceMode:[data objectForKey:@"inefaceMode"]];
                                   }else{
                                       [_delegate httpInterFaceDataCode:[[dic objectForKey:@"inforCode"] integerValue]  DataDic:[dic objectForKey:@"result"] interFaceMode:[data objectForKey:@"inefaceMode"]];
                                   }

                               }

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
/**
 * 获取用户的场景列表
 * [in]userId 用户id
 */
-(void)getUserScenarioList:(NSString *)userId userName:(NSString*)userName{

    NSDictionary *testDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             @"getUserScenarioList",@"inefaceMode",
                             userId,@"userId",
                             userName,@"userName",
                             nil];
    [self requestWithData:testDic];
}
@end
