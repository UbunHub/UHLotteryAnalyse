//
//  UHWebViewController.h
//  SmartHome-iOS
//
//  Created by UbunGit on 2016/10/29.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UHWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property(strong, nonatomic) NSURL *weburl;
    
@end
