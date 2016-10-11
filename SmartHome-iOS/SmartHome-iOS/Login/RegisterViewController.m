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
                NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:msg,@"remark",nil];
                [AlertView showAlertViewWithstyle:1001 Data:dic andDelegate:nil];
            }
        }];
    }else{

        NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"两次输入密码不一致",@"remark",nil];
        [AlertView showAlertViewWithstyle:1001 Data:dic andDelegate:nil];
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
