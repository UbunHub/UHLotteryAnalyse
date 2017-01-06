//
//  UHWebViewController.m
//  SmartHome-iOS
//
//  Created by UbunGit on 2016/10/29.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "UHWebViewController.h"

@interface UHWebViewController ()

@end

@implementation UHWebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSString *body = [NSString stringWithFormat: @"userName=%@&userImage=wahawje",[Global_Variable sharedInstance].userName];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_weburl];
    [request setHTTPMethod: @"post"];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setTimeoutInterval:30];
    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    [_webView loadRequest:request];
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}
- (IBAction)backDoit:(id)sender {
    if([_webView canGoBack]){
        [_webView goBack];
    }else{
        [_webView reload];
    }
}


@end
