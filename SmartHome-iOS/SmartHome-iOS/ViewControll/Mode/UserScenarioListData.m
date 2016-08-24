//
//  UserScenarioListData.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/4/20.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "UserScenarioListData.h"

@implementation UserScenarioListData
/**
 * 将字典数组解析为UserScenarioListData类型的数组
 */
+(NSArray*)getUserScenarioListWithArr:(NSArray*)dicArr{
    
    NSMutableArray *returnArr = [[NSMutableArray alloc]initWithCapacity:0];
    for (NSDictionary *dic in dicArr) {
        UserScenarioListData *data = [[UserScenarioListData alloc]init];
        data.scenarioId = [dic objectForKey:@"scenarioId"];
        data.scenarioName = [dic objectForKey:@"scenarioName"];
        data.scenariopic = [dic objectForKey:@"scenariopic"];
        [returnArr addObject:data];
    }
    return returnArr;
    //345678
}

@end
