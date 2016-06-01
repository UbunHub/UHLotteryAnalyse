//
//  AlertView.h
//  HLTddpay
//  显示有用户邀请去开宝箱的时候的提示
//  Created by dev on 15/9/13.
//  Copyright (c) 2015年 com.sanweidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertView_1001.h"
#import "MessageView_2002.h"
@class AlertView;

@protocol AlertViewDelegate <NSObject>

-(void)alertView:(AlertView*)alertView btnClicktag:(NSInteger)tag style:(NSInteger)style;

@end

@interface AlertView : UIView<AlertViewControllerDelegate>

@property (strong, nonatomic) id viewData;
@property (assign, nonatomic) id<AlertViewDelegate>delegate;

+(void)showAlertViewWithstyle:(NSInteger)style Data:(id)data andDelegate:delegate;

+(void)hiddenAlertView;

-(id)initWithstyle:(NSInteger)style andDelegate:delegate;

-(void)reloadViewWithviewData:(id)data;

@end

