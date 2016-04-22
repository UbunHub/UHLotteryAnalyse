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
    HttpInterFace *httpInterFace = [[HttpInterFace alloc]initWithDelegate:self];
    [httpInterFace getUserScenarioList:[Global_Variable sharedInstance].userId userName: [Global_Variable sharedInstance].userName];
}

-(void)httpInterFaceDataCode:(NSInteger)dataCode DataDic:(NSArray *)dataDic interFaceMode:(NSDictionary *)interFaceMode{

    if (dataCode == 0) {

        scenarioList =[[NSMutableArray alloc]initWithArray:[UserScenarioListData getUserScenarioListWithArr:dataDic]];
        [_collectionView reloadData];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return scenarioList.count+1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"DeviceGroupCell";
    DeviceGroupCell *cell = (DeviceGroupCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (scenarioList.count) {
        [cell relodeCellWithdata:[scenarioList objectAtIndex:indexPath.row]];
    }else{
        [cell relodeCellWithdata:[scenarioList objectAtIndex:indexPath.row]];
    }
    
    
    return cell;
}
@end
