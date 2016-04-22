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

@interface LoginViewController()

//用户名输入框
@property (weak, nonatomic) IBOutlet UITextField *userName_tf;
//密码输入框
@property (weak, nonatomic) IBOutlet UITextField *password_tf;
//登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
//注册按钮
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

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
}

//登录
- (IBAction)loginDoit:(id)sender {
    
    [self.view endEditing:YES];
    NSString *userName = _userName_tf.text;
    NSString *passWord = _password_tf.text;
    
    HttpInterFace *httpInterFace = [[HttpInterFace alloc]initWithDelegate:self];
    [httpInterFace logWithUserName:userName passWord:passWord];
}

- (IBAction)registerDoit:(id)sender {
    
    RegisterViewController* registerViewController = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

-(void)httpInterFaceDataCode:(NSInteger)dataCode DataDic:(NSDictionary *)dataDic interFaceMode:(NSDictionary *)interFaceMode{

    if (dataCode == 0) {

        [Global_Variable sharedInstance].userleave = [[dataDic objectForKey:@"userLevel"]integerValue];
        [Global_Variable sharedInstance].userId = [dataDic objectForKey:@"userId"];
        [Global_Variable sharedInstance].userName = [dataDic objectForKey:@"userName"];
        [Global_Variable sharedInstance].userTel = [dataDic objectForKey:@"userTel"];

        TabBarViewController *tabBarViewController = [[TabBarViewController alloc]init];
        UIWindow *awindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
        awindow.rootViewController = tabBarViewController;
        
    }
}

@end
