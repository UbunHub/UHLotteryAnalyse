//
//  BluetoothDetailsVC.h
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/4/21.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "SmartHomeViewController.h"

@interface BluetoothDetailsVC : SmartHomeViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *inputText;

@property (weak, nonatomic) IBOutlet UIButton *sendText;

@property (weak, nonatomic) IBOutlet UITextView *logText;
@end
