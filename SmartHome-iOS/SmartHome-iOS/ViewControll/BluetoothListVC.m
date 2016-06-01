//
//  BluetoothListVC.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/4/20.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "BluetoothListVC.h"
#import "DeviceCenter.h"

@implementation BluetoothListVC

-(void)viewDidLoad{

    [super viewDidLoad];
    self.navigationItem.title = @"设备扫描";
    [DeviceCenter sharedInstance].scanDidChangeBlock = ^(DeviceCenter* deviceCenter){
        [_tableView reloadData];
    };
    [[DeviceCenter sharedInstance] scanBluetooth];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [DeviceCenter sharedInstance].bluetoothArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"ShopTitleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    }
    CBPeripheral*cBPeripheral = [[DeviceCenter sharedInstance].bluetoothArr objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.frame = cell.bounds;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",cBPeripheral];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    CBPeripheral*cBPeripheral = [[DeviceCenter sharedInstance].bluetoothArr objectAtIndex:indexPath.row];
    [[DeviceCenter sharedInstance] linkBEL:cBPeripheral];
}
@end
