//
//  LoginViewController.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/3/4.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "LoginViewController.h"
#import "HttpRequest_OS.h"

@implementation LoginViewController

- (IBAction)loginDoit:(id)sender {

    NSDictionary *testDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"log",@"inefaceMode",@"test123",@"userName", @"123456",@"passWord",nil];
    HttpRequest_OS *http = [[HttpRequest_OS alloc]init];
    
    [http synchronousRequestWithType:DATATYPE_INPUT_XML requestUrl:[NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/weather?q=London,uk"] InputDataDic:testDic];
}

@end
