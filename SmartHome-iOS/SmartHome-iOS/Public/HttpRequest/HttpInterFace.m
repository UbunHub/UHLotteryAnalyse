//
//  HttpInterFace.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/3/10.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "HttpInterFace.h"
#import "NSDictionary+NSDictionaryCategory.h"
#import "AFURLSessionManager.h"

@implementation HttpInterFace


-(void)requestWithData:(NSDictionary*)data interPath:(NSString*)interPath
            beginBlock:(HttpInterFaceBeginBlock)beginBlock
              endBlock:(HttpInterFaceEndBlock)endBlock{
    
    NSString *requestStr;
    _inputDataType = (_inputDataType)?_inputDataType:DATATYPE_INPUT_JSON;
    
    switch (_inputDataType) {
        case DATATYPE_INPUT_XML:
            requestStr = [data xmlStringWithStartElement:nil isFirstElement:NO];
            break;
        case DATATYPE_INPUT_JSON:
            requestStr = [data jsonStringWithPrettyPrint:YES];
        default:
            break;
    }
 
    NSString *urlStr = [NSString stringWithFormat:@"%@:%d/%@",InterFaceIP,InterFacePort,interPath];
    NSURL *url = [NSURL URLWithString:urlStr];
    DbgLog(@"\n-------bengin--------\n请求接口路径：%@ \n请求参数：%@\n---------end----------\n\n",url,requestStr );
    NSString *interFaceMode = [data objectForKey:@"inefaceMode"];
    [self synchronousRequestWithuserName:@""
                              requestUrl:url
                              requestStr:requestStr
                       completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                           
                           NSError *httpErr;
                           NSDictionary *dataDic;
                           
                           
                           if (error ) {
                               
                               httpErr = error;
                               
                           } else if(!responseObject){
                               
                               
                               httpErr = [NSError errorWithDomain:@"返回数据为空" code:10001 userInfo:nil];
                           }else{
                               
                               NSDictionary *dic =(NSDictionary*)responseObject;
                               NSInteger dataCode = [[dic objectForKey:@"inforCode"]integerValue];
                               if (dataCode!=0) {
                                   httpErr = [NSError errorWithDomain:[dataDic objectForKey:@"result"] code:dataCode userInfo:nil];
                               }else{
                                   dataDic = dic;
                               }
                           }
                           if (endBlock) {
                               endBlock(httpErr,dataDic,interFaceMode);
                           }
                           
                       }];
}

/**
 * 同步请求
 * dataType 请求服务器发送的数据格式
 */
-(void)synchronousRequestWithuserName:(NSString *)userName
                           requestUrl:(NSURL*)requestUrl
                           requestStr:(NSString*)requestStr
                    completionHandler:(nullable void (^)(NSURLResponse *, id _Nullable, NSError * _Nullable))completionHandler{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [configuration setTimeoutIntervalForRequest:30.0];
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

/**
 * 登录
 * [in]userName 用户名
 * [in]passWord 密码
 */
-(void)logWithUserName:(NSString *)userName passWord:(NSString*)passWord
            beginBlock:(HttpInterFaceBeginBlock)beginBlock
              endBlock:(HttpInterFaceEndBlock)endBlock{
    
    NSDictionary *testDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             @"log",@"inefaceMode",
                             userName,@"userName",
                             passWord,@"passWord",
                             nil];
    [self requestWithData:testDic interPath:@"interface" beginBlock:beginBlock endBlock:endBlock];
}

/**
 * 注册
 * [in]tel 电话号码
 * [in]passWord 密码
 */
-(void)registerWithTelNO:(NSString*)tel passWord:(NSString*)passWord
              beginBlock:(HttpInterFaceBeginBlock)beginBlock
                endBlock:(HttpInterFaceEndBlock)endBlock{
    
    NSDictionary *testDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             @"register",@"inefaceMode",
                             tel,@"tel",
                             passWord,@"passWord",
                             nil];
    [self requestWithData:testDic interPath:@"interface" beginBlock:beginBlock endBlock:endBlock];
    
    
}
/**
 * 获取用户的场景列表
 * [in]userId 用户id
 */
-(void)getUserScenarioList:(NSString *)userId userName:(NSString*)userName
                beginBlock:(HttpInterFaceBeginBlock)beginBlock
                  endBlock:(HttpInterFaceEndBlock)endBlock{
    
    NSDictionary *testDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             @"getUserScenarioList",@"inefaceMode",
                             userId,@"userId",
                             userName,@"userName",
                             nil];
    [self requestWithData:testDic interPath:@"interface" beginBlock:beginBlock endBlock:endBlock];
}

/**
 * 获取彩票数据
 */
-(void)getFC3dDataWithPageSize:(NSString*)pageSize PageNum:(NSString*)pageNum
                    beginBlock:(HttpInterFaceBeginBlock)beginBlock
                      endBlock:(HttpInterFaceEndBlock)endBlock{
    
    NSDictionary *testDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             @"getFC3DData",@"inefaceMode",
                             pageSize,@"pageSize",
                             pageNum,@"pageNum",
                             nil];
    [self requestWithData:testDic interPath:@"FCAnalyse" beginBlock:beginBlock endBlock:endBlock];
}

/**
 *获取推荐的号码
 */
-(void)getRecommendCodeWithBeginOutNO:(NSString*)beginOutNO
                             EndOutNO:(NSString*)endOutNO
                          Probability:(NSString*)probability
                       RecommendOutON:(NSString*)recommendOutON
                           beginBlock:(HttpInterFaceBeginBlock)beginBlock
                             endBlock:(HttpInterFaceEndBlock)endBlock{
    
    NSDictionary *testDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             @"getRecommendCode",@"inefaceMode",
                             beginOutNO,@"BeginOutNO",
                             endOutNO,@"EndOutNO",
                             probability,@"Probability",
                             recommendOutON,@"RecommendOutON",
                             nil];
    [self requestWithData:testDic interPath:@"FCAnalyse" beginBlock:beginBlock endBlock:endBlock];
    
}



- (void)getOmitDataWithPageSize:(NSString *)pageSize
                        pageNum:(NSString *)pageNum
                     beginBlock:(HttpInterFaceBeginBlock)beginBlock
                       endBlock:(HttpInterFaceEndBlock)endBlock{
    
    NSDictionary *testDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             @"getOmitData",@"inefaceMode",
                             pageSize,@"pageSize",
                             pageNum,@"pageNum",
                             nil];
    [self requestWithData:testDic interPath:@"FCAnalyse" beginBlock:beginBlock endBlock:endBlock];
}
@end
