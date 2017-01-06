//
//  FCShowDataVC.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/8/18.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "FCShowDataVC.h"
#import "FCCollectionViewCell.h"
#import "RecommendInfoVC.h"



@interface FCShowDataVC ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet UICollectionView *dataCollectionView;


@end

@implementation FCShowDataVC{
    NSMutableArray *dataArr;
    NSArray *gekeyArr;
    NSArray *shikeyArr;
    NSArray *baikeyArr;
    NSArray *selectKeyArr;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    selectKeyArr = gekeyArr = [[NSArray alloc]initWithObjects:
                @"outdate",@"Ge_Zero",@"Ge_One",@"Ge_Two",@"Ge_Three",@"Ge_Four",
                @"Ge_Five",@"Ge_Six",@"Ge_Seven",@"Ge_Eight",@"Ge_Nine" ,nil];
    shikeyArr = [[NSArray alloc]initWithObjects:
                 @"outdate",@"Shi_Zero",@"Shi_One",@"Shi_Two",@"Shi_Three",@"Shi_Four",
                 @"Shi_Five",@"Shi_Six",@"Shi_Seven",@"Shi_Eight",@"Shi_Nine" ,nil];
    baikeyArr = [[NSArray alloc]initWithObjects:
                 @"outdate",@"Bai_Zero",@"Bai_One",@"Bai_Two",@"Bai_Three",@"Bai_Four",
                 @"Bai_Five",@"Bai_Six",@"Bai_Seven",@"Bai_Eight",@"Bai_Nine" ,nil];

    self.navigationItem.title = @"3D历史";
    UIBarButtonItem * todatBar = [[UIBarButtonItem alloc]initWithTitle:@"今日预测" style:UIBarButtonItemStylePlain target:self action:@selector(showTodayData)];
    self.navigationItem.rightBarButtonItem = todatBar;
    _dataCollectionView.delegate   = self;
    _dataCollectionView.dataSource = self;
    _dataCollectionView.backgroundColor = [UIColor whiteColor];
    //注册collectionview的cell
    [_dataCollectionView registerClass:[FCCollectionViewCell class] forCellWithReuseIdentifier:@"FCCollectionViewCell"];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self getHttpData];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize  = CGSizeMake((self.view.frame.size.width -11) /11, (self.view.frame.size.width -11) /11);
    layout.sectionInset            = UIEdgeInsetsMake(0, 0, 1, 1);
    layout.minimumInteritemSpacing = 0.0;
    layout.minimumLineSpacing      = 0.0;
    _dataCollectionView.collectionViewLayout =layout;
}

- (void)showTodayData{
    
    NSDictionary *dicdata = [dataArr firstObject];
    RecommendInfoVC*recommendList = [[RecommendInfoVC alloc]init];
    NSInteger outNO = [dicdata[@"outNO"] intValue]+1;
    recommendList.recommendOutON = [NSString stringWithFormat:@"%d",(int)(outNO+1)];
    [self.navigationController pushViewController:recommendList animated:YES];
    
}
- (IBAction)seletedValueChange:(UISegmentedControl*)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            selectKeyArr = gekeyArr;
            break;
        case 1:
            selectKeyArr =shikeyArr;
            break;
        case 2:
            selectKeyArr =baikeyArr;
            break;
            
        default:
            break;
    }
    [_dataCollectionView reloadData];
}

static BOOL isHttping;
-(void)getHttpData{
    
    NSInteger pageNum = dataArr.count/10;
    if (isHttping) {
        return;
    }
    
    
    NSString* pageNumStr = [NSString stringWithFormat:@"%d",(int)pageNum];
    
    HttpInterFace *httpInterFace = [[HttpInterFace alloc]init];
    [httpInterFace getOmitDataWithPageSize:@"20" pageNum:pageNumStr beginBlock:^(NSString *mode) {
        isHttping = YES;
    } endBlock:^(NSError *error, NSDictionary *dataDic, NSString *mode) {
        isHttping = NO;
        if (!error) {
            if (!dataArr) {
                dataArr = [NSMutableArray arrayWithArray:[dataDic objectForKey:@"result"]];
            }else{
                [dataArr addObjectsFromArray:[dataDic objectForKey:@"result"]];
            }
            
            [_dataCollectionView reloadData];
            
        }else{
            
            NSString * msg = [dataDic objectForKey:@"result"];
            [UHAlertManager alertSysMessage:msg title:@"温馨提示" Controller:self clickBlock:^(id sender, UIViewController *info) {
                ;
            } button:@"确定",nil];
        }
    }];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return dataArr.count;
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 11;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FCCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FCCollectionViewCell" forIndexPath:indexPath];
    
    NSDictionary *data = [dataArr objectAtIndex:indexPath.section];
  
    if (indexPath.section == 0){
        cell.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1];
        cell.layer.cornerRadius = 0;
        cell.detailLabel.text = indexPath.row == 0?@"期数":[NSString stringWithFormat:@"%d",(int)indexPath.row -1];
    }else{
        
        
        NSNumber * temNum= [data objectForKey:selectKeyArr[indexPath.row]];
        if ([temNum integerValue] == 0) {

            cell.layer.cornerRadius = cell.bounds.size.width/2;
            temNum =[NSNumber numberWithInteger:indexPath.row-1];
            cell.backgroundColor = [UIColor greenColor];
        }else{
            cell.layer.cornerRadius = 0;
            cell.backgroundColor =((indexPath.section%2)>0)?[UIColor colorWithRed:245.0/255 green:240.0/255 blue:240.0/255 alpha:1]: [UIColor whiteColor];
        }
            
        cell.detailLabel.text = [NSString stringWithFormat:@"%@",temNum];
    }
    
    [self setNowCount];
   return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RecommendInfoVC* recommendInfoVC = [[RecommendInfoVC alloc]init];
    NSDictionary *data = [dataArr objectAtIndex:indexPath.section];
    recommendInfoVC.recommendOutON = data[@"outNO"];
    [self.navigationController pushViewController:recommendInfoVC animated:YES];
    
}

-(void)setNowCount{
    
    NSArray*nowShow = [_dataCollectionView  indexPathsForVisibleItems];
    NSInteger temCount = 0;
    
    for (NSIndexPath *index in nowShow) {
        temCount = (index.section>temCount)?index.section:temCount;
    }
    if (temCount>(dataArr.count-2)) {
        
        [self getHttpData];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
