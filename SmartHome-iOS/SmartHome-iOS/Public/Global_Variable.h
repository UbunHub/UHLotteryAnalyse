//
//  Global_Variable.h
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/3/4.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnumValue.h"
#import "DefineValue.h"

@interface Global_Variable : NSObject

@property(strong, nonatomic)NSString *userName;//用户名
@property(strong, nonatomic)NSString *userId;//用户id
@property(assign, nonatomic)NSInteger userleave;//会员等级
@property(strong, nonatomic)NSString *userTel;//会员电话号码

+(Global_Variable *) sharedInstance;
@end
