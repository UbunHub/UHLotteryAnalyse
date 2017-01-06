//
//  UHDefaulAlert.m
//  Demo
//
//  Created by xiaoqy on 16/9/8.
//  Copyright © 2016年 com.sanweidu.TDDPayBLE. All rights reserved.
//

#import "UHDefaulAlert.h"

@interface UHDefaulAlert ()

@end

@implementation UHDefaulAlert

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadViewWith:(NSDictionary *)dic{
    [super reloadViewWith:dic];
    _message.text = [dic objectForKey:@"message"];
    _alertTitle.text = [dic objectForKey:@"alertTitle"];
}

@end
