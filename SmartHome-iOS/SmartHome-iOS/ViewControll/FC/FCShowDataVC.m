//
//  FCShowDataVC.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/8/18.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "FCShowDataVC.h"
#import "FCShowDataCell.h"
#import "RecommendList.h"
@interface FCShowDataVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *dataTableView;

@end

@implementation FCShowDataVC{
    NSMutableArray *dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"3D历史";
    UIBarButtonItem * todatBar = [[UIBarButtonItem alloc]initWithTitle:@"今日预测" style:UIBarButtonItemStylePlain target:self action:@selector(showTodayData)];
    self.navigationItem.rightBarButtonItem = todatBar;
   
}

- (void)showTodayData{
    
    NSLog(@"点击了");

}
-(void)viewWillAppear:(BOOL)animated{
     [self getHttpData];
}
static BOOL isHttping;
-(void)getHttpData{
    
    NSInteger pageNum = dataArr.count/10;
    if (isHttping) {
        return;
    }
    isHttping = YES;
 
    NSString* pageNumStr = [NSString stringWithFormat:@"%d",(int)pageNum];
    
    HttpInterFace *httpInterFace = [[HttpInterFace alloc]initWithDelegate:self];
    [httpInterFace getFC3dDataWithPageSize:@"10" PageNum:pageNumStr];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 69.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"FCShowDataCell";
    FCShowDataCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[FCShowDataCell alloc] init];
        
    }
    NSDictionary *dicdata = [dataArr objectAtIndex:indexPath.row];
    [cell setUIWithData:dicdata];
    [self setNowCount];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSDictionary *dicdata = [dataArr objectAtIndex:indexPath.row];
    RecommendList*recommendList = [[RecommendList alloc]init];
    recommendList.recommendOutON =dicdata[@"outNO"];
    [self.navigationController pushViewController:recommendList animated:YES];
}

-(void)setNowCount{
    
    NSArray*nowShow = [_dataTableView  indexPathsForVisibleRows];
    NSInteger temCount = 0;
    
    for (NSIndexPath *index in nowShow) {
        temCount = (index.row>temCount)?index.row:temCount;
    }
    if (temCount>(dataArr.count-5)) {
        
        [self getHttpData];
    }
}

-(void)httpInterFaceDataCode:(NSInteger)dataCode DataDic:(NSDictionary *)dataDic interFaceMode:(NSString *)interFaceMode{
    isHttping = NO;
    if (dataCode == 0) {
        if (!dataArr) {
            dataArr = [NSMutableArray arrayWithArray:[dataDic objectForKey:@"result"]];
        }else{
            [dataArr addObjectsFromArray:[dataDic objectForKey:@"result"]];
        }
        
        [_dataTableView reloadData];
 
    }else{
        
        NSString * msg = [dataDic objectForKey:@"result"];
        NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:msg,@"remark",nil];
        [AlertView showAlertViewWithstyle:1001 Data:dic andDelegate:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
