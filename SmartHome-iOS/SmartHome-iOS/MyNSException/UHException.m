//
//  UHException.m
//  HuiWang
//
//  Created by xiaoqy on 16/9/6.
//  Copyright © 2016年 com.sanweidu.TDDPayBLE. All rights reserved.
//

#import "UHException.h"
#import <stdio.h>

@implementation UHException

+(UHException*)UHExceptionWithCode:(NSInteger)code
                           Message:(NSString*)msg
                            Leveal:(UHEXLEVEAL)leveal
                              Info:(NSDictionary*)info
                              View:(UIView*)showView{
    
    UHException *ex = [[UHException alloc]init];
    ex.exCode = code;
    ex.exMsg = msg;
    ex.exLeveal = leveal;
    ex.exInfo = info;
    
    if (!showView) {
        showView = [UIApplication sharedApplication].keyWindow;
    }
    ex.exView = showView;
    return ex;
}

-(void)dealWith{
    
    DbgLog(@"%@",self.exMsg);
    switch (self.exLeveal) {
            
        case UH_INFO:
           
            break;
        case UH_WARNING:{
            
            MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.exView];
            [self.exView addSubview:HUD];
            HUD.detailsLabelText = self.exMsg;
            HUD.detailsLabelFont = [UIFont systemFontOfSize:17];
            HUD.mode = MBProgressHUDModeText;
            [HUD showAnimated:YES whileExecutingBlock:^{
                sleep(2.3);
            } completionBlock:^{
                [HUD removeFromSuperview];
            }];
        }
            break;
        case UH_ERROR:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    
}
@end
