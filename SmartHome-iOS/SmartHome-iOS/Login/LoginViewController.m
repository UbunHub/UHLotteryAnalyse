//
//  LoginViewController.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/3/4.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

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

-(void)httpInterFaceDataWithDic:(NSDictionary *)dataDic error:(NSError *)error{
    
}
@end
