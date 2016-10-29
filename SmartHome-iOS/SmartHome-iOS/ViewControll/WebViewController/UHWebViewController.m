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
    [_webView loadRequest:[NSURLRequest requestWithURL:_weburl]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
