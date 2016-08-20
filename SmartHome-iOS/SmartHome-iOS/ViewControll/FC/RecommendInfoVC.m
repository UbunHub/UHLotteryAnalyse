//
//  RecommendInfoVC.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/8/19.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "RecommendInfoVC.h"

@interface RecommendInfoVC ()

@property (weak, nonatomic) IBOutlet UILabel *geIstrue_lab;

@property (weak, nonatomic) IBOutlet UILabel *shiIsTrue_lab;

@property (weak, nonatomic) IBOutlet UILabel *baiIsTrue_lab;

@property (weak, nonatomic) IBOutlet UILabel *geRecCode_lab;

@property (weak, nonatomic) IBOutlet UILabel *geOutCode_lab;

@property (weak, nonatomic) IBOutlet UILabel *shiRecCode_lab;

@property (weak, nonatomic) IBOutlet UILabel *shiOutCode_lab;

@property (weak, nonatomic) IBOutlet UILabel *baiRecCode_lab;

@property (weak, nonatomic) IBOutlet UILabel *baiOutCode_lab;
@end


@implementation RecommendInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getHttpData];
}
-(void)getHttpData{
    HttpInterFace *httpInterFace = [[HttpInterFace alloc]initWithDelegate:self];
    [httpInterFace getRecommendCodeWithBeginOutNO:@"2002050" EndOutNO:@"2016223" Probability:_probability RecommendOutON:_recommendOutON];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)reloadUIWithDic:(NSDictionary*)dataDic{
    BOOL geIsTrue = [dataDic[@"geIsTrue"] boolValue];
    _geIstrue_lab.textColor = (geIsTrue)?[UIColor blueColor]:[UIColor redColor];
    _geIstrue_lab.text = dataDic[@"geIsTrue"];
    
    _geOutCode_lab.text = [NSString stringWithFormat:@"实际数字:  %@",[[dataDic objectForKey:@"outData"] objectForKey:@"out_ge"]];
    for (NSString *str in dataDic[@"outGeList"]) {
        _geRecCode_lab.text = [NSString stringWithFormat:@"%@ %@",_geRecCode_lab.text,str];
    }
    BOOL shiIsTrue = [dataDic[@"shiIsTrue"] boolValue];
    _shiIsTrue_lab.textColor = (shiIsTrue)?[UIColor blueColor]:[UIColor redColor];
     _shiIsTrue_lab.text = dataDic[@"shiIsTrue"];

    _shiOutCode_lab.text =  [NSString stringWithFormat:@"实际数字:  %@",[[dataDic objectForKey:@"outData"] objectForKey:@"out_shi"]];
    for (NSString *str in dataDic[@"outShiList"]) {
        _shiRecCode_lab.text = [NSString stringWithFormat:@"%@ %@",_shiRecCode_lab.text,str];
    }
    
    BOOL baiIsTrue = [dataDic[@"baiIsTrue"] boolValue];
    _baiIsTrue_lab.textColor = (baiIsTrue)?[UIColor blueColor]:[UIColor redColor];
    _baiIsTrue_lab.text = dataDic[@"baiIsTrue"];

   _baiOutCode_lab.text = [NSString stringWithFormat:@"实际数字:  %@",[[dataDic objectForKey:@"outData"] objectForKey:@"out_bai"]];
    for (NSString *str in dataDic[@"outBaiList"]) {
        _baiRecCode_lab.text = [NSString stringWithFormat:@"%@ %@",_baiRecCode_lab.text,str];
    }
    
}

-(void)httpInterFaceDataCode:(NSInteger)dataCode DataDic:(NSDictionary *)dataDic interFaceMode:(NSString *)interFaceMode{

    if (dataCode == 0) {
        [self reloadUIWithDic:dataDic[@"result"]];
        
    }else{
        
        NSString * msg = [dataDic objectForKey:@"result"];
        NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:msg,@"remark",nil];
        [AlertView showAlertViewWithstyle:1001 Data:dic andDelegate:nil];
    }
}


@end
