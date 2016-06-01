//
//  AlertViewControllerDelegate.h
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/5/9.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AlertViewControllerDelegate <NSObject>

-(void)alertViewclicketBtnTag:(NSInteger)tag data:(id)data;

@end
