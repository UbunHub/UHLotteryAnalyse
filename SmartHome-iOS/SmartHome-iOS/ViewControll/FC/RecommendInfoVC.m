//
//  RecommendInfoVC.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/8/19.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "RecommendInfoVC.h"

@interface RecommendInfoVC ()

@property (weak, nonatomic) IBOutlet UITableView *dataTableView;

@property(strong, nonatomic)NSMutableArray *dataArr;

@property (weak, nonatomic) IBOutlet UILabel *geRecCode_lab;

@property (weak, nonatomic) IBOutlet UILabel *geKillCode_lab;

@property (weak, nonatomic) IBOutlet UILabel *geOutCode_lab;

@property (weak, nonatomic) IBOutlet UILabel *shiRecCode_lab;

@property (weak, nonatomic) IBOutlet UILabel *shiKillCode_lab;

@property (weak, nonatomic) IBOutlet UILabel *shiOutCode_lab;

@property (weak, nonatomic) IBOutlet UILabel *baiRecCode_lab;

@property (weak, nonatomic) IBOutlet UILabel *baiKillCode_lab;

@property (weak, nonatomic) IBOutlet UILabel *baiOutCode_lab;

@property (weak, nonatomic) IBOutlet UILabel *outCountLab;

@property (weak, nonatomic) IBOutlet UILabel *zhiRecMoneLab;

@property (weak, nonatomic) IBOutlet UILabel *zhiKillMoneLab;


@end


@implementation RecommendInfoVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _dataTableView.layer.cornerRadius = 16;
    _dataTableView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.dataArr = [[NSMutableArray alloc]initWithObjects:@"5",@"10",@"15",@"20",@"25",@"30",@"50",@"100",  nil];
    [self getHttpDataWithProbability:[_dataArr firstObject]];
}

-(void)getHttpDataWithProbability:(NSString*)probability{
    
    HttpInterFace *httpInterFace = [[HttpInterFace alloc]initWithDelegate:self];
    [httpInterFace getRecommendCodeWithBeginOutNO:@"2002050" EndOutNO:@"2016223" Probability:probability RecommendOutON:_recommendOutON];
}

-(void)reloadUIWithDic:(NSDictionary*)dataDic{

    _geOutCode_lab.text = [NSString stringWithFormat:@"%@",[[dataDic objectForKey:@"outData"] objectForKey:@"out_ge"]];
    
    _geRecCode_lab.text = @"";
    for (NSString *str in dataDic[@"outGeList"]) {
        _geRecCode_lab.text = [NSString stringWithFormat:@"%@ %@",_geRecCode_lab.text,str];
    }
    BOOL geIsTrue = [dataDic[@"geIsTrue"] boolValue];
    _geRecCode_lab.textColor = (geIsTrue)?[UIColor blueColor]:[UIColor redColor];
    
    _geKillCode_lab.text = @"";
    for (NSString *str in dataDic[@"outNotGeList"]) {
        _geKillCode_lab.text = [NSString stringWithFormat:@"%@ %@",_geKillCode_lab.text,str];
    }
    BOOL geNotIsTrue = [dataDic[@"geNotIsTrue"] boolValue];
    _geKillCode_lab.textColor = (geNotIsTrue)?[UIColor blueColor]:[UIColor redColor];
    
    _shiOutCode_lab.text =  [NSString stringWithFormat:@" %@",[[dataDic objectForKey:@"outData"] objectForKey:@"out_shi"]];
    _shiRecCode_lab.text = @"";
    for (NSString *str in dataDic[@"outShiList"]) {
        _shiRecCode_lab.text = [NSString stringWithFormat:@"%@ %@",_shiRecCode_lab.text,str];
    }
    BOOL shiIsTrue = [dataDic[@"shiIsTrue"] boolValue];
    _shiRecCode_lab.textColor = (shiIsTrue)?[UIColor blueColor]:[UIColor redColor];
    
    _shiKillCode_lab.text = @"";
    for (NSString *str in dataDic[@"outNotShiList"]) {
        _shiKillCode_lab.text = [NSString stringWithFormat:@"%@ %@",_shiKillCode_lab.text,str];
    }
    BOOL shiNotIsTrue = [dataDic[@"shiNotIsTrue"] boolValue];
    _shiKillCode_lab.textColor = (shiNotIsTrue)?[UIColor blueColor]:[UIColor redColor];
    
    _baiOutCode_lab.text = [NSString stringWithFormat:@"%@",[[dataDic objectForKey:@"outData"] objectForKey:@"out_bai"]];
    _baiRecCode_lab.text = @"";
    for (NSString *str in dataDic[@"outBaiList"]) {
        _baiRecCode_lab.text = [NSString stringWithFormat:@"%@ %@",_baiRecCode_lab.text,str];
    }
    BOOL baiIsTrue = [dataDic[@"baiIsTrue"] boolValue];
    _baiRecCode_lab.textColor = (baiIsTrue)?[UIColor blueColor]:[UIColor redColor];
    _baiKillCode_lab.text = @"";
    for (NSString *str in dataDic[@"outNotBaiList"]) {
        _baiKillCode_lab.text = [NSString stringWithFormat:@"%@ %@",_baiKillCode_lab.text,str];
    }
    BOOL baiNotIsTrue = [dataDic[@"baiNotIsTrue"] boolValue];
    _baiKillCode_lab.textColor = (baiNotIsTrue)?[UIColor blueColor]:[UIColor redColor];
    
    _outCountLab.text = [NSString stringWithFormat:@"%@ %@",[[dataDic objectForKey:@"outData"]objectForKey:@"outdate"],[[dataDic objectForKey:@"outData"]objectForKey:@"outNO"]];
    NSArray *outGeList = dataDic[@"outGeList"];
    NSArray *outShiList = dataDic[@"outShiList"];
    NSArray *outBaiList = dataDic[@"outBaiList"];
    NSArray *outNotGeList = dataDic[@"outNotGeList"];
    NSArray *outNotShiList = dataDic[@"outNotShiList"];
    NSArray *outNotBaiList = dataDic[@"outNotBaiList"];
    _zhiRecMoneLab.text =[NSString stringWithFormat:@"%d元",(int)(2*outGeList.count*outShiList.count*outBaiList.count)];
    _zhiKillMoneLab.text =[NSString stringWithFormat:@"%d元",(int)(2*(10-outNotGeList.count)*(10-outNotShiList.count)*(10-outNotBaiList.count))];
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    NSString *str = [_dataArr objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [NSString stringWithFormat:@"%@期统计",str];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [_dataArr objectAtIndex:indexPath.row];
    [self getHttpDataWithProbability:str];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
