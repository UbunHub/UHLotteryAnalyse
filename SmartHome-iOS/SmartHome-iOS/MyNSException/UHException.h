//
//  UHException.h
//  HuiWang
//
//  Created by xiaoqy on 16/9/6.
//  Copyright © 2016年 com.sanweidu.TDDPayBLE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UHAlertManager.h"
#import "MBProgressHUD.h"

//气泡报错
#define UHWarning(code, msg) \
UHException *ex =[UHException UHExceptionWithCode:code Message:msg Leveal:UH_WARNING Info:nil View:nil];\
[ex dealWith];
//根据错误码获取报错信息
#define UHAlertMsgstr(code, msg) \
[UHException UHExceptionWithCode:code Message:msg Leveal:UH_WARNING Info:nil View:nil].exMsg
//只有确定按钮的alert
#define UHAlertMsg(code,msg)\
[UHAlertManager alertSysMessage:UHAlertMsgstr(code, msg) title:nil Controller:self clickBlock:nil button:@"确定",nil];

enum UHEXLEVEAL{
    
    UH_INFO,
    UH_WARNING,
    UH_ERROR,
};

@interface UHException : NSObject

@property(assign, nonatomic) NSInteger exCode; //异常码

@property(assign, nonatomic) UHEXLEVEAL exLeveal; //异常等级

@property(strong, nonatomic) NSString* exMsg; //异常描述

@property(strong, nonatomic) NSDictionary* exInfo; //异常描述

@property(strong, nonatomic)UIView *exView;//提示错误的容器

+(UHException*)UHExceptionWithCode:(NSInteger)code
                           Message:(NSString*)msg
                            Leveal:(UHEXLEVEAL)leveal
                              Info:(NSDictionary*)info
                              View:(UIView*)showView;

-(void)dealWith;
@end

