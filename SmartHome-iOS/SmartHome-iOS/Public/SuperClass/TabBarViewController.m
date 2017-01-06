//
//  TabBarViewController.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/4/20.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "TabBarViewController.h"
#import "GoodsListVC.h"
#import "AboutUsVC.h"
#import "FCShowDataVC.h"
#import "UHWebViewController.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UHWebViewController *webViewcornller = [[UHWebViewController alloc]init];
    webViewcornller.weburl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/xiaoqy/index.php",InterFaceIP]];
    UINavigationController *webViewNav = [[UINavigationController alloc]initWithRootViewController:webViewcornller];

    FCShowDataVC *fcShowDataVC = [[FCShowDataVC alloc]init];
    UINavigationController *fcShowDataNav = [[UINavigationController alloc]initWithRootViewController:fcShowDataVC];

    AboutUsVC *aboutUsVC = [[AboutUsVC alloc]init];
    UINavigationController *aboutUsNav = [[UINavigationController alloc]initWithRootViewController:aboutUsVC];

    self.viewControllers = [NSArray arrayWithObjects:fcShowDataNav,webViewNav,aboutUsNav, nil];

    UITabBar *tabBar= self.tabBar;

    UITabBarItem *firstItem = [tabBar.items objectAtIndex:0];
    firstItem.title = @"彩票";

    UITabBarItem *secItem = [tabBar.items objectAtIndex:1];
    secItem.title = @"Smart";

    UITabBarItem *fourItem = [tabBar.items objectAtIndex:2];
    fourItem.title = @"关于";

}




@end
