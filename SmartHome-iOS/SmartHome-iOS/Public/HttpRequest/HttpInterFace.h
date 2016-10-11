//
//  HttpInterFace.h
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/3/10.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpInterFace : NSObject

typedef void(^HttpInterFaceBeginBlock)(NSString* mode);
typedef void(^HttpInterFaceEndBlock)(NSError *error, NSDictionary *dataDic, NSString* mode);

//请求数据类型
@property(assign, nonatomic) HTTPREQUEST_DATATYPE_INPUT inputDataType;

/**
 * 登录
 * [in]userName 用户名
 * [in]passWord 密码
 */
-(void)logWithUserName:(NSString *)userName passWord:(NSString*)passWord
            beginBlock:(HttpInterFaceBeginBlock)beginBlock
              endBlock:(HttpInterFaceEndBlock)endBlock;

/**
 * 注册
 * [in]tel 电话号码
 * [in]passWord 密码
 */
-(void)registerWithTelNO:(NSString*)tel
                passWord:(NSString*)passWord
              beginBlock:(HttpInterFaceBeginBlock)beginBlock
                endBlock:(HttpInterFaceEndBlock)endBlock;

/**
 * 获取用户的场景列表
 * [in]userId 用户id
 * [in]userName 用户名
 */
-(void)getUserScenarioList:(NSString *)userId userName:(NSString*)userName
                beginBlock:(HttpInterFaceBeginBlock)beginBlock
                  endBlock:(HttpInterFaceEndBlock)endBlock;

/**
 * 获取彩票数据
 */
-(void)getFC3dDataWithPageSize:(NSString*)pageSize PageNum:(NSString*)pageNum
                    beginBlock:(HttpInterFaceBeginBlock)beginBlock
                      endBlock:(HttpInterFaceEndBlock)endBlock;

/**
 *获取推荐的号码
 */
-(void)getRecommendCodeWithBeginOutNO:(NSString*)beginOutNO
                             EndOutNO:(NSString*)endOutNO
                          Probability:(NSString*)probability
                       RecommendOutON:(NSString*)recommendOutON
                           beginBlock:(HttpInterFaceBeginBlock)beginBlock
                             endBlock:(HttpInterFaceEndBlock)endBlock;

- (void)getOmitDataWithPageSize:(NSString *)pageSize
                        pageNum:(NSString *)pageNum
                     beginBlock:(HttpInterFaceBeginBlock)beginBlock
                       endBlock:(HttpInterFaceEndBlock)endBlock;
@end
