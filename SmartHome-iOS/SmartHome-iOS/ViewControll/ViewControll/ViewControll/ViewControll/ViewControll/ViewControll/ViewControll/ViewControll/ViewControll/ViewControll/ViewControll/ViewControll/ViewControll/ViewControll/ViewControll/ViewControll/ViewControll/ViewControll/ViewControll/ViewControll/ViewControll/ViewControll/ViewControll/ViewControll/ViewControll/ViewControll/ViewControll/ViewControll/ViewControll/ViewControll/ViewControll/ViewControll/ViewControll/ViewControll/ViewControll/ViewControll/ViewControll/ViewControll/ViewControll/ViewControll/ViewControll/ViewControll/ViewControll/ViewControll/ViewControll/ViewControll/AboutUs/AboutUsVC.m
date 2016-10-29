//
//  AboutUsVC.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/5/10.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "AboutUsVC.h"

@interface AboutUsVC ()

@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender {

    UIViewController* rootViewController = [[NSClassFromString(@"LoginViewController") alloc] init];
    UINavigationController* rootNavController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    UIWindow *awindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
    awindow.rootViewController = rootNavController;
    [awindow makeKeyAndVisible];
}


@end
