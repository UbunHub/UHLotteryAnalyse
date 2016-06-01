//
//  AlertView.m
//  HLTddpay
//
//  Created by dev on 15/9/13.
//  Copyright (c) 2015年 com.sanweidu. All rights reserved.
//

#import "AlertView.h"

static AlertView *staticAlertView = nil;

@implementation AlertView{
    NSInteger viewstyle;
    UIViewController *alertView;
}
+(void)showAlertViewWithstyle:(NSInteger)style Data:(id)data andDelegate:delegate{


    if (staticAlertView) {
        if (staticAlertView->viewstyle != style) {

            staticAlertView = nil;
            staticAlertView  = [[AlertView alloc] initWithstyle:style andDelegate:delegate];
        }
    }else{
        staticAlertView  = [[AlertView alloc] initWithstyle:style andDelegate:delegate];
    }

    [staticAlertView reloadViewWithviewData:data];
    UIWindow *awindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [awindow addSubview:staticAlertView->alertView.view];


}

+(void)hiddenAlertView{

    [staticAlertView->alertView.view removeFromSuperview];
}

-(id)initWithstyle:(NSInteger)style andDelegate:delegate{

    if (self = [super initWithFrame:CGRectZero]) {
        viewstyle = style;
        _delegate = delegate;
        [self setUI];
    }
    return self;
}
-(void)setUI{

    switch (viewstyle) {
        case 1001:
            [self set1001UI];
            break;
        case 2001:
            [self set2002UI];
            break;

        default:
            break;
    }
}
-(void)reloadViewWithviewData:(id)data{

    switch (viewstyle) {
        case 1001:
        {

            AlertView_1001 *temView = (AlertView_1001*)alertView;
            [temView reloadViewWithData:data];
        }
            break;
        case 2001:
        {

            MessageView_2002 *temView = (MessageView_2002*)alertView;
            [temView reloadViewWithData:data];
        }
            break;

        default:
            break;
    }

}
-(void)alertViewclicketBtnTag:(NSInteger)tag data:(id)data{

    if ([_delegate respondsToSelector:@selector(alertView:btnClicktag:style:)]) {
        [_delegate alertView:self btnClicktag:tag style:viewstyle];
    }
    [staticAlertView->alertView.view removeFromSuperview];
}


-(void)set1001UI{
    AlertView_1001 *temalertView = [[AlertView_1001 alloc]init];
    temalertView.delegate = self;
    [self setFrame:temalertView.view.bounds];
    [self addSubview:temalertView.view];
    alertView = temalertView;
}
-(void)set2002UI{
    MessageView_2002 *temalertView = [[MessageView_2002 alloc]init];
    [self setFrame:temalertView.view.bounds];
    [self addSubview:temalertView.view];
    alertView = temalertView;
}

@end

