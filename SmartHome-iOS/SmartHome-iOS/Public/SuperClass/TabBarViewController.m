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

    FCShowDataVC *goodsListVC = [[FCShowDataVC alloc]init];
    UINavigationController *goodsListNav = [[UINavigationController alloc]initWithRootViewController:goodsListVC];


    BluetoothListVC *bluetoothListVC = [[BluetoothListVC alloc]init];
    UINavigationController *bluetoothListNav = [[UINavigationController alloc]initWithRootViewController:bluetoothListVC];


    AboutUsVC *aboutUsVC = [[AboutUsVC alloc]init];
    UINavigationController *aboutUsNav = [[UINavigationController alloc]initWithRootViewController:aboutUsVC];

    self.viewControllers = [NSArray arrayWithObjects:deviceGroupNav,goodsListNav,bluetoothListNav,aboutUsNav, nil];

    UITabBar *tabBar= self.tabBar;

    UITabBarItem *firstItem = [tabBar.items objectAtIndex:0];
    firstItem.title = @"HOME";

    UITabBarItem *secItem = [tabBar.items objectAtIndex:1];
    secItem.title = @"彩票";

    UITabBarItem *thiItem = [tabBar.items objectAtIndex:2];
    thiItem.title = @"扫描";

    UITabBarItem *fourItem = [tabBar.items objectAtIndex:3];
    fourItem.title = @"关于";

}




@end
