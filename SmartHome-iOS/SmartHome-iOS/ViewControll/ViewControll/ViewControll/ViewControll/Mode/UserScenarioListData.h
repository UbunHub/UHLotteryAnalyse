//
//  UserScenarioListData.h
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/4/20.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserScenarioListData : NSObject

@property(strong, nonatomic)NSString *scenarioId;//场景id
@property(strong, nonatomic)NSString *scenarioName;//场景名
@property(strong, nonatomic)NSString *scenariopic;//场景图片

/**
 * 将字典数组解析为UserScenarioListData类型的数组
 */
+(NSArray*)getUserScenarioListWithArr:(NSArray*)dicArr;
@end
