//
//  AlertView_1001.h
//  HLTddpay
//
//  Created by dev on 15/9/14.
//  Copyright (c) 2015年 com.sanweidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertViewControllerDelegate.h"


@interface AlertView_1001 : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *title_lab;//标题

@property (weak, nonatomic) IBOutlet UILabel *remark_lab;//描述

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;//左按钮

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;//右按钮

@property (weak, nonatomic) IBOutlet UIImageView *alertImageView;//提示框颜色

@property (assign, nonatomic) id<AlertViewControllerDelegate>delegate;

-(void)reloadViewWithData:(NSDictionary*)data;
@end


