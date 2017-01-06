//
//  UHDefaulAlert.h
//  Demo
//
//  Created by xiaoqy on 16/9/8.
//  Copyright © 2016年 com.sanweidu.TDDPayBLE. All rights reserved.
//

#import "UHAlertviewSuperVC.h"

@interface UHDefaulAlert : UHAlertviewSuperVC

@property (weak, nonatomic) IBOutlet UILabel *alertTitle;

@property (weak, nonatomic) IBOutlet UILabel *message;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end
