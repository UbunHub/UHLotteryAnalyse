//
//  DeviceGroupVC.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/4/15.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "DeviceGroupVC.h"
#import "DeviceGroupCell.h"
@implementation DeviceGroupVC
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.collectionView registerClass:[DeviceGroupCell class] forCellWithReuseIdentifier:@"DeviceGroupCell"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 19;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"DeviceGroupCell";
    DeviceGroupCell *cell = (DeviceGroupCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    return cell;
}
@end
