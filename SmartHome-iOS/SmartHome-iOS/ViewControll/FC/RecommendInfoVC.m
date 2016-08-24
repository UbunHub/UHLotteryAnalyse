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
    self.dataArr = [[NSMutableArray alloc]initWithObjects:@"5",@"10",@"15",@"20",@"25",@"30",@"50",@"100",  nil];
    [self getHttpDataWithProbability:[_dataArr firstObject]];
}

-(void)getHttpDataWithProbability:(NSString*)probability{
    
    HttpInterFace *httpInterFace = [[HttpInterFace alloc]initWithDelegate:self];
    [httpInterFace getRecommendCodeWithBeginOutNO:@"2002050" EndOutNO:@"2016223" Probability:probability RecommendOutON:_recommendOutON];
}

-(void)reloadUIWithDic:(NSDictionary*)dataDic{
    
    BOOL geIsTrue = [dataDic[@"geIsTrue"] boolValue];
    _geIstrue_lab.textColor = (geIsTrue)?[UIColor blueColor]:[UIColor redColor];
    _geIstrue_lab.text = dataDic[@"geIsTrue"];
    
    _geOutCode_lab.text = [NSString stringWithFormat:@"实际数字:  %@",[[dataDic objectForKey:@"outData"] objectForKey:@"out_ge"]];
    _geRecCode_lab.text = @"";
    for (NSString *str in dataDic[@"outGeList"]) {
        _geRecCode_lab.text = [NSString stringWithFormat:@"%@ %@",_geRecCode_lab.text,str];
    }
    BOOL shiIsTrue = [dataDic[@"shiIsTrue"] boolValue];
    _shiIsTrue_lab.textColor = (shiIsTrue)?[UIColor blueColor]:[UIColor redColor];
    _shiIsTrue_lab.text = dataDic[@"shiIsTrue"];
    
    _shiOutCode_lab.text =  [NSString stringWithFormat:@"实际数字:  %@",[[dataDic objectForKey:@"outData"] objectForKey:@"out_shi"]];
    _shiRecCode_lab.text = @"";
    for (NSString *str in dataDic[@"outShiList"]) {
        _shiRecCode_lab.text = [NSString stringWithFormat:@"%@ %@",_shiRecCode_lab.text,str];
    }
    
    BOOL baiIsTrue = [dataDic[@"baiIsTrue"] boolValue];
    _baiIsTrue_lab.textColor = (baiIsTrue)?[UIColor blueColor]:[UIColor redColor];
    _baiIsTrue_lab.text = dataDic[@"baiIsTrue"];
    
    _baiOutCode_lab.text = [NSString stringWithFormat:@"实际数字:  %@",[[dataDic objectForKey:@"outData"] objectForKey:@"out_bai"]];
    _baiRecCode_lab.text = @"";
    for (NSString *str in dataDic[@"outBaiList"]) {
        _baiRecCode_lab.text = [NSString stringWithFormat:@"%@ %@",_baiRecCode_lab.text,str];
    }
    
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
        
    }
    NSString *str = [_dataArr objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [NSString stringWithFormat:@"%@期统计",str];
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
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
