//
//  UHAlertviewSuperVC.m
//  Pods
//
//  Created by xiaoqy on 16/9/7.
//
//

#import "UHAlertviewSuperVC.h"

@interface UHAlertviewSuperVC ()



@end

@implementation UHAlertviewSuperVC


-(void)reloadViewWith:(NSDictionary *)dic{
    
    _coniew.layer.cornerRadius = 12;
}

- (IBAction)alertClicked:(UIButton *)sender forEvent:(UIEvent *)event {
    
    [self dismissViewControllerAnimated:NO completion:^{
        if (_clickBlock) {
            _clickBlock(sender,self);
        }
    }];
}

@end
