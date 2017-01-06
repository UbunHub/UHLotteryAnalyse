//
//  RegisterViewController.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/3/10.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

//手机号码
@property (weak, nonatomic) IBOutlet UITextField *telNO_tf;
//密码
@property (weak, nonatomic) IBOutlet UITextField *passWord_tf;
//确认密码
@property (weak, nonatomic) IBOutlet UITextField *rePassWord_tf;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


/**
 * 注册
 */
- (IBAction)register:(id)sender {
    
    [self.view endEditing:YES];
    NSString *telStr = _telNO_tf.text;
    NSString *passWordStr = _passWord_tf.text;
    NSString *rePassWordStr = _rePassWord_tf.text;
    
    if([passWordStr isEqualToString:rePassWordStr]){
        
        HttpInterFace *httpInterFace = [[HttpInterFace alloc]init];
        [httpInterFace registerWithTelNO:telStr passWord:passWordStr beginBlock:^(NSString *mode) {
            ;
        } endBlock:^(NSError *error, NSDictionary *dataDic, NSString *mode) {
            if (!error) {
                
                
            }else{
                
                NSString * msg = [dataDic objectForKey:@"result"];
                [UHAlertManager alertSysMessage:msg title:@"温馨提示" Controller:self clickBlock:^(id sender, UIViewController *info) {
                    ;
                } button:@"确定",nil];
            }
        }];
    }else{

        [UHAlertManager alertSysMessage:@"两次输入密码不一致" title:@"温馨提示" Controller:self clickBlock:^(id sender, UIViewController *info) {
            ;
        } button:@"确定",nil];
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
