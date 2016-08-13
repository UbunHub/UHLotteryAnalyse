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
    //////
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://shop.img.3weidu.com/life/5578994d-e749-4bf3-9dbf-a21a460cc201.gif"] placeholderImage:nil options:nil];
//
    [[HttpDownloadManager sharedManager] downloadImageWithURL:[NSURL URLWithString:@"http://shop.img.3weidu.com/life/1c8cd898-bc40-48f5-a976-95c00cc4846c.gif"] options:HttpDownLoadRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(NSData *data, NSError *error, DataCacheType cacheType, BOOL finished, NSURL *imageURL) {
        DbgLog(@"");
    }];
    //////
//    [AlertView showAlertViewWithstyle:2001 Data:nil andDelegate:self];
//    HttpInterFace *httpInterFace = [[HttpInterFace alloc]initWithDelegate:self];
//    [httpInterFace logWithUserName:userName passWord:passWord];
}

- (IBAction)registerDoit:(id)sender {
    
    RegisterViewController* registerViewController = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

-(void)httpInterFaceDataCode:(NSInteger)dataCode DataDic:(NSDictionary *)dataDic interFaceMode:(NSString *)interFaceMode{
    [AlertView hiddenAlertView];
    if (dataCode == 0) {
        NSDictionary *data = [dataDic objectForKey:@"result"];
        [Global_Variable sharedInstance].userleave = [[data objectForKey:@"userLevel"]integerValue];
        [Global_Variable sharedInstance].userId = [data objectForKey:@"userId"];
        [Global_Variable sharedInstance].userName = [data objectForKey:@"userName"];
        [Global_Variable sharedInstance].userTel = [data objectForKey:@"userTel"];

        TabBarViewController *tabBarViewController = [[TabBarViewController alloc]init];
        UIWindow *awindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
        awindow.rootViewController = tabBarViewController;

    }else{

        NSString * msg = [dataDic objectForKey:@"result"];
        NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:msg,@"remark",nil];
        [AlertView showAlertViewWithstyle:1001 Data:dic andDelegate:nil];
    }
}

@end
