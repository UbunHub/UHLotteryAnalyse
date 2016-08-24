//
//  TabBarViewController.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/4/20.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "TabBarViewController.h"
#import "DeviceGroupVC.h"
#import "GoodsListVC.h"
#import "BluetoothListVC.h"
#import "AboutUsVC.h"
#import "FCShowDataVC.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    DeviceGroupVC *deviceGroupVC = [[DeviceGroupVC alloc]init];
    UINavigationController *deviceGroupNav = [[UINavigationController alloc]initWithRootViewController:deviceGroupVC];

    FCShowDataVC *fcShowDataVC = [[FCShowDataVC alloc]init];
    UINavigationController *fcShowDataNav = [[UINavigationController alloc]initWithRootViewController:fcShowDataVC];


    BluetoothListVC *bluetoothListVC = [[BluetoothListVC alloc]init];
    UINavigationController *bluetoothListNav = [[UINavigationController alloc]initWithRootViewController:bluetoothListVC];


    AboutUsVC *aboutUsVC = [[AboutUsVC alloc]init];
    UINavigationController *aboutUsNav = [[UINavigationController alloc]initWithRootViewController:aboutUsVC];

    self.viewControllers = [NSArray arrayWithObjects:fcShowDataNav,deviceGroupNav,bluetoothListNav,aboutUsNav, nil];

    UITabBar *tabBar= self.tabBar;

    UITabBarItem *firstItem = [tabBar.items objectAtIndex:0];
    firstItem.title = @"彩票";

    UITabBarItem *secItem = [tabBar.items objectAtIndex:1];
    secItem.title = @"Smart";

    UITabBarItem *thiItem = [tabBar.items objectAtIndex:2];
    thiItem.title = @"扫描";

    UITabBarItem *fourItem = [tabBar.items objectAtIndex:3];
    fourItem.title = @"关于";

}




@end
