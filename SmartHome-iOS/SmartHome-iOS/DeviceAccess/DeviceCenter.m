//
//  DeviceCenter.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/4/20.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "DeviceCenter.h"

static NSString * const kServiceUUID = @"1C85D7B7-17FA-4362-82CF-85DD0B76A9A5";
static NSString * const kCharacteristicUUID = @"7E887E40-95DE-40D6-9AA0-36EDE2BAE253";

@implementation DeviceCenter{

    CBCentralManager *manager;
    NSMutableArray *nServices;
}

static DeviceCenter * sharedInstance =nil;
+(DeviceCenter *) sharedInstance{

    @synchronized(self)
    {
        if (sharedInstance ==nil){

            sharedInstance = [[DeviceCenter alloc]init];
        }
    }
    return sharedInstance;
}
-(instancetype)init{

    if (self ==[super init]) {
        manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        _bluetoothArr = [[NSMutableArray alloc]initWithCapacity:0];
        nServices = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

/**
 * 开始扫描蓝牙设备
 */
-(void)scanBluetooth{



}

/**
 * 链接设备
 */
-(void)linkBEL:(CBPeripheral*)peripheral{

    [manager connectPeripheral:peripheral options:nil];
}

/**
 * 停止扫描
 */
-(void)stopScan{

    [manager stopScan];
}

//开始查看服务，蓝牙开启
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{

    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
        {
            NSLog(@"蓝牙已打开,请扫描外设");
            [manager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
        }
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@"蓝牙没有打开,请先打开蓝牙");
            break;
        default:
            break;
    }
}
//scan到设备就会调用此方法
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{

    if (![_bluetoothArr containsObject:peripheral]) {
        [_bluetoothArr addObject:peripheral];

        if (_scanDidChangeBlock) {
            _scanDidChangeBlock(self);
        }
    }
}
//连接外设时调用
- (void) centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{

    _linkbluetooth = nil;
    NSLog(@"已断开与设备:[%@]的连接", peripheral);
}

//当连接上一个外设  CBCentralManager 代理 处理此方法
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {

    NSLog(@"%@", [NSString stringWithFormat:@"成功连接 peripheral: %@ with UUID: %@",peripheral,peripheral.identifier]);
    [self stopScan];
    _linkbluetooth = peripheral;
    [_linkbluetooth setDelegate:self];
    [_linkbluetooth discoverServices:nil];
}
//连接外设失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{

    NSLog(@"%@",error);
}
#pragma mark -- CBPeripheralDelegate

-(void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%s,%@",__PRETTY_FUNCTION__,peripheral);
    int rssi = abs([peripheral.RSSI intValue]);
    NSInteger ci = (rssi - 49) / (10 * 4.0);
    NSString *length = [NSString stringWithFormat:@"发现BLT4.0热点:%@,距离:%.1fm",peripheral,pow(10,ci)];
    NSLog(@"距离：%@",length);
}

//已发现服务
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{

    NSLog(@"发现服务.");
    if (error)
    {
        NSLog(@"Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
        return;
    }
    NSInteger i=0;
    for (CBService *s in peripheral.services) {
         NSLog(@"%d :服务 UUID: %@(%@)",(int)i,s.UUID.data,s.UUID);
        [nServices addObject:s];

        [peripheral discoverCharacteristics:nil forService:s];
    }

}

//已搜索到Characteristics
-(void) peripheral:(CBPeripheral *)peripheral
didDiscoverCharacteristicsForService:(CBService *)service
             error:(NSError *)error{

    if (error)
    {
        NSLog(@"Error discovering characteristic: %@", [error localizedDescription]);
        return;
    }
    NSLog(@"发现特征的服务:%@ (%@)",service.UUID.data ,service.UUID);
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        NSLog(@"----didDiscoverCharacteristicsForService---%@",characteristic);

            [peripheral readValueForCharacteristic:characteristic];
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    }
}
//处理蓝牙发过来的数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
NSLog(@"----value更新----");
}
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error)
    {
        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }

    // Exits if it's not the transfer characteristic
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUID]] )
    {
        // Notification has started
        if (characteristic.isNotifying)
        {
            NSLog(@"Notification began on %@", characteristic);
            [peripheral readValueForCharacteristic:characteristic];
        }
        else
        { // Notification has stopped
            // so disconnect from the peripheral
            NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
            [manager cancelPeripheralConnection:peripheral];
        }
    }
}

//发送成功调用
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSLog(@"---didWriteValueForCharacteristic-----");
    if (error) {
        NSLog(@"%@",error.domain);
    }else{
        NSLog(@"%@",characteristic);
    }


}


@end
