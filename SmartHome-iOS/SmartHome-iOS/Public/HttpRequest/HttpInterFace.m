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

-(void)requestWithData:(NSDictionary*)data interPath:(NSString*)interPath{

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
//    NSString *urlStr = [NSString stringWithFormat:@"http://45.78.9.162:8889/%@",interPath];
    NSString *urlStr = [NSString stringWithFormat:@"http://192.168.1.27:8080/%@",interPath];
    NSURL *url = [NSURL URLWithString:urlStr];
    DbgLog(@"\n-------bengin--------\n请求接口路径：%@ \n请求参数：%@\n---------end----------\n\n",url,requestStr );

    [http synchronousRequestWithuserName:@""
                              requestUrl:url
                              requestStr:requestStr
                       completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {

                           NSInteger dataCode;
                           NSDictionary *dataDic;
                           NSString *interFaceMode = [data objectForKey:@"inefaceMode"];

                           if (error ) {

                               dataCode = error.code;
                               dataDic = [[NSDictionary alloc]initWithObjectsAndKeys:error.domain,@"result" ,nil];

                           } else if(!responseObject){

                               dataCode = 10001;
                               dataDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"返回数据为空",@"result" ,nil];
                           }else{

                               NSDictionary *dic =(NSDictionary*)responseObject;
                               dataCode = [[dic objectForKey:@"inforCode"]integerValue];
                               dataDic = dic;

                           }
                           [self returnDelegateWithDataCode:dataCode DataDic:dataDic interFaceMode:interFaceMode];

                       }];
}
-(void)returnDelegateWithDataCode:(NSInteger)dataCode DataDic:(NSDictionary *)dataDic interFaceMode:(NSString *)interFaceMode{
    DbgLog(@"\n-------bengin-------\n%@接口返回数据:\n返回码：%d:\n返回数据：%@:\n------end--------\n\n",interFaceMode,(int)dataCode,dataDic);

    if ([_delegate respondsToSelector:@selector(httpInterFaceDataCode:DataDic:interFaceMode:)]) {
        [_delegate httpInterFaceDataCode:dataCode
                                 DataDic:dataDic
                           interFaceMode:interFaceMode];
    }
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
    [self requestWithData:testDic interPath:@"interface"];
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
    [self requestWithData:testDic interPath:@"interface"];


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
    [self requestWithData:testDic interPath:@"interface"];
}

/**
 * 获取彩票数据
 */
-(void)getFC3dDataWithPageSize:(NSString*)pageSize PageNum:(NSString*)pageNum{
    
    NSDictionary *testDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             @"getFC3DData",@"inefaceMode",
                             pageSize,@"pageSize",
                             pageNum,@"pageNum",
                             nil];
    [self requestWithData:testDic interPath:@"FCAnalyse"];
}

/**
 *获取推荐的号码
 */
-(void)getRecommendCodeWithBeginOutNO:(NSString*)beginOutNO
                             EndOutNO:(NSString*)endOutNO
                          Probability:(NSString*)probability
                       RecommendOutON:(NSString*)recommendOutON{
    
    NSDictionary *testDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             @"getRecommendCode",@"inefaceMode",
                             beginOutNO,@"BeginOutNO",
                             endOutNO,@"EndOutNO",
                             probability,@"Probability",
                             recommendOutON,@"RecommendOutON",
                             nil];
    [self requestWithData:testDic interPath:@"FCAnalyse"];
    
}



- (void)getOmitDataWithPageSize:(NSString *)pageSize
                        pageNum:(NSString *)pageNum{

    NSDictionary *testDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                             @"getOmitData",@"inefaceMode",
                             pageSize,@"pageSize",
                             pageNum,@"pageNum",
                             nil];
    [self requestWithData:testDic interPath:@"FCAnalyse"];



}
@end
