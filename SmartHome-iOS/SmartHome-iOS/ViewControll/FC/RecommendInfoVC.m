//
//  RecommendInfoVC.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/8/19.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "RecommendInfoVC.h"

@interface RecommendInfoVC ()

@end

@implementation RecommendInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getHttpData];
}
-(void)getHttpData{
    HttpInterFace *httpInterFace = [[HttpInterFace alloc]initWithDelegate:self];
    [httpInterFace getRecommendCodeWithBeginOutNO:@"2016000" EndOutNO:@"2016223" Probability:@"5" RecommendOutON:@"2016224"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)httpInterFaceDataCode:(NSInteger)dataCode DataDic:(NSDictionary *)dataDic interFaceMode:(NSString *)interFaceMode{

    if (dataCode == 0) {
     
        
    }else{
        
        NSString * msg = [dataDic objectForKey:@"result"];
        NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:msg,@"remark",nil];
        [AlertView showAlertViewWithstyle:1001 Data:dic andDelegate:nil];
    }
}

@end
