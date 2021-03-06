//
//  LoginViewController.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/3/4.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "TabBarViewController.h"
#import "HttpDownloadManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@interface LoginViewController()

//用户名输入框
@property (weak, nonatomic) IBOutlet UITextField *userName_tf;
//密码输入框
@property (weak, nonatomic) IBOutlet UITextField *password_tf;
//登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
//注册按钮
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet UIImageView *loginBg;
@end

@implementation LoginViewController


-(void)viewDidLoad{

    [super viewDidLoad];

    _loginBtn.backgroundColor = [UIColor redColor];
    _loginBtn.layer.masksToBounds = NO;
     [_loginBtn.layer setBorderWidth:0.5];//设置边框宽度
    [_loginBtn.layer setBorderColor: [[UIColor colorWithRed: 255.0/255   green:255.0/255 blue:0.0/255 alpha:0.5 ]CGColor]];//设置边框颜色
    _loginBtn.layer.cornerRadius = 5; // 设置层的弧度
    _loginBtn.layer.shadowOffset = CGSizeMake(0, 0);//设置阴影偏移量
    _loginBtn.layer.shadowColor =  [[UIColor colorWithRed: 255.0/255   green:255.0/255 blue:0.0/255 alpha:1 ]CGColor];//设置阴影颜色
    _loginBtn.layer.shadowOpacity = 0.5;//设置阴影的透明度
    [_loginBg sd_setImageWithURL:UGImage(@"LoginBg.jpg")];
}

//登录
- (IBAction)loginDoit:(id)sender {
    
    [self.view endEditing:YES];
    NSString *userName = _userName_tf.text;
    NSString *passWord = _password_tf.text;

    HttpInterFace *httpInterFace = [[HttpInterFace alloc]init];
    [httpInterFace logWithUserName:userName passWord:passWord beginBlock:^(NSString *mode) {
        ;
    } endBlock:^(NSError *error, NSDictionary *dataDic, NSString *mode) {
        if (!error) {
            NSDictionary *data = [dataDic objectForKey:@"result"];
            [Global_Variable sharedInstance].userleave = [[data objectForKey:@"userLevel"]integerValue];
            [Global_Variable sharedInstance].userId = [data objectForKey:@"userId"];
            [Global_Variable sharedInstance].userName = [data objectForKey:@"userName"];
            [Global_Variable sharedInstance].userTel = [data objectForKey:@"userTel"];
            
            TabBarViewController *tabBarViewController = [[TabBarViewController alloc]init];
            UIWindow *awindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
            awindow.rootViewController = tabBarViewController;
            
        }else{
            
            [UHAlertManager alertSysMessage:error.domain title:@"温馨提示" Controller:self clickBlock:nil button:@"确定",nil];
        }
    }];
}

- (IBAction)registerDoit:(id)sender {

    RegisterViewController* registerViewController = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}


@end
