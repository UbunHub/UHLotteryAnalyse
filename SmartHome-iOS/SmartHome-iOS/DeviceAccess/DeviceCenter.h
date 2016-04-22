//
//  DeviceCenter.h
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/4/20.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>



@interface DeviceCenter : NSObject<CBCentralManagerDelegate, CBPeripheralDelegate>


typedef void(^DeviceCenterScanDidChangeBlock)(DeviceCenter*deviceCenter);

@property(readonly, nonatomic)NSMutableArray *bluetoothArr;//发现的蓝牙列表

@property(readonly)CBPeripheral *linkbluetooth;//链接的蓝牙设备

@property(nonatomic,strong) DeviceCenterScanDidChangeBlock scanDidChangeBlock;
+(DeviceCenter *) sharedInstance;
/**
 * 开始扫描蓝牙设备
 */
-(void)scanBluetooth;

/**
 * 链接设备
 */
-(void)linkBEL:(CBPeripheral*)belDic;

/**
 * 停止扫描
 */
-(void)stopScan;

@end
