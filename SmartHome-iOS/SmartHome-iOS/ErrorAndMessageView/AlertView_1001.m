//
//  AlertView_1001.m
//  HLTddpay
//
//  Created by dev on 15/9/14.
//  Copyright (c) 2015年 com.sanweidu. All rights reserved.
//

#import "AlertView_1001.h"


@implementation AlertView_1001

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setFrame:CGRectMake(0, 0, Screen_width, Screen_height)];
}

-(void)reloadViewWithData:(NSDictionary*)data{

    if (data[@"title"]) {
        _title_lab.text = data[@"title"];
    }else{
        _title_lab.text = @"温馨提示";
    }
    if (data[@"remark"]) {
        _remark_lab.text = data[@"remark"];
    }else{
        _remark_lab.text = @"错误";
    }
    if (data[@"leftTitle"]) {

         [_leftBtn setTitle:data[@"leftTitle"] forState:UIControlStateNormal];
    }else{
          [_leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    }
    if (data[@"rightTitle"]) {
        [_rightBtn setTitle:data[@"rightTitle"] forState:UIControlStateNormal];
    }else{
        [_rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    }
    if (data[@"alertImage"]) {
        [_alertImageView setImage:data[@"alertImage"]];
    }else{
        _alertImageView.image = nil;
    }
    if (data[@"bgColor"]) {
        self.view.backgroundColor = data[@"bgColor"];
    }else{
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
    _alertImageView.layer.cornerRadius = 6;

}



- (IBAction)butClick:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(alertViewclicketBtnTag:data:)]) {
        [_delegate alertViewclicketBtnTag:1001 data:self];
    }
}

@end
