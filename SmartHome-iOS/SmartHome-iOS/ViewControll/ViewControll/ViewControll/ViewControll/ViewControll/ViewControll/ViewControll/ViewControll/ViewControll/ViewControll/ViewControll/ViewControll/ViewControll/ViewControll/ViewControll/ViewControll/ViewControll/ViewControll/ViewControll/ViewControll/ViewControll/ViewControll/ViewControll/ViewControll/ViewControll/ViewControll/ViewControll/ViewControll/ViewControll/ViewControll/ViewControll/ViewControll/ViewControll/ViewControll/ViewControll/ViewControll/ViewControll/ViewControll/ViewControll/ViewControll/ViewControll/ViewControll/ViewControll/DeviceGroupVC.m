//
//  DeviceGroupVC.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/4/15.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "DeviceGroupVC.h"
#import "DeviceGroupCell.h"
#import "UserScenarioListData.h"

@implementation DeviceGroupVC{

    NSMutableArray *scenarioList;
}

-(void)viewDidLoad{

    [super viewDidLoad];
    self.navigationItem.title = @"HOME";
    [self getHttpData];
    [self.collectionView registerClass:[DeviceGroupCell class] forCellWithReuseIdentifier:@"DeviceGroupCell"];
}

-(void)getHttpData{
    HttpInterFace *httpInterFace = [[HttpInterFace alloc]init];
    [httpInterFace getUserScenarioList:[Global_Variable sharedInstance].userId userName: [Global_Variable sharedInstance].userName beginBlock:^(NSString *mode) {
        ;
    } endBlock:^(NSError *error, NSDictionary *dataDic, NSString *mode) {
        if (!error) {
            NSArray * dataArr = [dataDic objectForKey:@"result"];
            scenarioList =[[NSMutableArray alloc]initWithArray:[UserScenarioListData getUserScenarioListWithArr:dataArr]];
            [_collectionView reloadData];
        }else{
            NSString * msg = [dataDic objectForKey:@"result"];
            NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:msg,@"remark",nil];
            [AlertView showAlertViewWithstyle:1001 Data:dic andDelegate:nil];
        }
    }];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return scenarioList.count+1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"DeviceGroupCell";
    DeviceGroupCell *cell = (DeviceGroupCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (scenarioList.count == indexPath.row) {
        UserScenarioListData *addData = [[UserScenarioListData alloc]init];
        addData.scenarioId = @"00";
        addData.scenarioName = @"新增";
        addData.scenariopic = @"http://192.168.1.27/xiaoqy/SmartHome/Image/add.png";
        [cell relodeCellWithdata:addData];
    }else{
        [cell relodeCellWithdata:[scenarioList objectAtIndex:indexPath.row]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


    [AlertView showAlertViewWithstyle:1001 Data:nil andDelegate:self];
    
}
@end
