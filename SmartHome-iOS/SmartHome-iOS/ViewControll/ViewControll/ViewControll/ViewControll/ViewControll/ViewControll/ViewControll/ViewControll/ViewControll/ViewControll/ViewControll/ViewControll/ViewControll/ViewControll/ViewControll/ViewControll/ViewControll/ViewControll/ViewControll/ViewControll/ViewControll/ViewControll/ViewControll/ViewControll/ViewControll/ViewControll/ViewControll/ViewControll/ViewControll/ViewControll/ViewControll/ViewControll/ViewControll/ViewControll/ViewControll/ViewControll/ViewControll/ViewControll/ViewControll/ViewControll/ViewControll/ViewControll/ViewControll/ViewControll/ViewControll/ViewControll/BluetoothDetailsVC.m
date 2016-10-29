//
//  BluetoothDetailsVC.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/4/21.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "BluetoothDetailsVC.h"
#import "DeviceCenter.h"
@interface BluetoothDetailsVC ()

@end

@implementation BluetoothDetailsVC{
    CBService*selectService;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [DeviceCenter sharedInstance].linkbluetooth.services.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"ShopTitleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    }
    CBService*cBService = [[DeviceCenter sharedInstance].linkbluetooth.services objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.frame = cell.bounds;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",cBService];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    CBService*cBService = [[DeviceCenter sharedInstance].linkbluetooth.services objectAtIndex:indexPath.row];
    selectService = cBService;
    CBCharacteristic *characteristic = selectService.characteristics;

        //发送数据
        Byte ACkValue[3] = {0};
        ACkValue[0] = 0xe0; ACkValue[1] = 0x00; ACkValue[2] = ACkValue[0] + ACkValue[1];
        NSData *data = [NSData dataWithBytes:&ACkValue length:sizeof(ACkValue)];
        [[DeviceCenter sharedInstance].linkbluetooth writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];

}

@end
