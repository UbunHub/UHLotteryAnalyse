//
//  UHAlertManager.m
//  Pods
//
//  Created by xiaoqy on 16/9/7.
//
//

#import "UHAlertManager.h"
#import "YYImage.h"

@implementation UHAlertManager

static NSMutableDictionary *alertDic = nil;

+(void)alertStyle:(NSString*)style
             info:(NSDictionary*)info
       Controller:(UIViewController*)controller
       clickBlock:(UHAlertClickBlock)clickBlock{
    
    if (!alertDic) {
        alertDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    if ([style isEqualToString:@"system"]) {
        
        NSString *message = [info objectForKey:@"message"];
        NSString *title = [info objectForKey:@"title"];
        NSMutableArray *butNameArr = [[NSMutableArray alloc]init];
        for (NSString *str in info.allKeys) {
            [butNameArr addObject:[info objectForKey:str]];
        }
        
        [UHAlertManager alertSysMessage:message title:title preferredStyle:UIAlertControllerStyleAlert Controller:controller clickBlock:clickBlock buttonArr:butNameArr];
        
    }else{
        
        UHAlertviewSuperVC *alertVC = [alertDic objectForKey:style];
        if (!alertVC) {
            alertVC = [[NSClassFromString(style) alloc] init];
            [alertDic setObject:alertVC forKey:style];
        }
        alertVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        alertVC.view.backgroundColor = [UIColor clearColor];
        [controller presentViewController:alertVC animated:YES completion:nil];
        alertVC.clickBlock = clickBlock;
        [alertVC reloadViewWith:info];
    }
}

//系统样式
+(void)alertSysMessage:(NSString*)msg
                 title:(NSString*)title
        preferredStyle:(UIAlertControllerStyle)preferredStyle
            Controller:(UIViewController*)controller
            clickBlock:(UHAlertClickBlock)clickBlock
             buttonArr:(NSArray*)butNameArr{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:preferredStyle];
        
        for (NSString *str in butNameArr) {
            
            UIAlertAction *alertAction;
            alertAction = [UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                
                if (clickBlock) clickBlock(action,alertController);
            }];
            [alertController addAction:alertAction];
        }
        [controller presentViewController:alertController animated:YES completion:nil];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        for (NSString *str in butNameArr) {
            [alertView addButtonWithTitle:str];
        }
        [alertView show];
    }
}

static MBProgressHUD *loadMB = nil;

+(void)showLoadinfo:(NSDictionary*)info
            Conview:(UIView*)conview{
    if (!loadMB) {
        loadMB = [[MBProgressHUD alloc]initWithView:conview];
        YYImage *image = [YYImage imageNamed:@"loading"];
        YYAnimatedImageView *yyimageView = [[YYAnimatedImageView alloc] initWithImage:image];
        loadMB.customView = yyimageView;
    }
    [conview addSubview:loadMB];
    if ([info objectForKey:@"title"]) {
        loadMB.labelText = [info objectForKey:@"title"];
    }else{
       loadMB.labelText = @"加载中";
    }
    
    loadMB.mode = MBProgressHUDModeCustomView;
    [loadMB show:YES];
}
+(void)hiddleLoad{
    [loadMB hide:YES];
}

//系统样式
+(void)alertSysMessage:(NSString*)msg
                 title:(NSString*)title
            Controller:(UIViewController*)controller
            clickBlock:(UHAlertClickBlock)clickBlock
                button:(NSString*)butTitle, ...{
    
    NSMutableArray *butNameArr = [[NSMutableArray alloc]init];
    [butNameArr addObject:butTitle];
    va_list args;
    va_start(args, butTitle);
    if (butTitle)
    {
        NSString *otherString;
        while ((otherString = va_arg(args, NSString *)))
        {
            [butNameArr addObject:otherString];
        }
    }
    va_end(args);
    
    [UHAlertManager alertSysMessage:msg title:title preferredStyle:UIAlertControllerStyleAlert Controller:controller clickBlock:clickBlock buttonArr:butNameArr];
}


+(void)alertSheetSysMessage:(NSString*)msg
                      title:(NSString*)title
                 Controller:(UIViewController*)controller
                 clickBlock:(UHAlertClickBlock)clickBlock
                     button:(NSString*)butTitle, ...{
    
    NSMutableArray *butNameArr = [[NSMutableArray alloc]init];
    [butNameArr addObject:butTitle];
    va_list args;
    va_start(args, butTitle);
    if (butTitle)
    {
        NSString *otherString;
        while ((otherString = va_arg(args, NSString *)))
        {
            [butNameArr addObject:otherString];
        }
    }
    va_end(args);
    
    [UHAlertManager alertSysMessage:msg title:title preferredStyle:UIAlertControllerStyleActionSheet Controller:controller clickBlock:clickBlock buttonArr:butNameArr];
    
}
//默认样式
+(void)alertDefaul:(NSString*)msg
             title:(NSString*)title
        Controller:(UIViewController*)controller
        clickBlock:(UHAlertClickBlock)clickBlock
            button:(NSString*)butTitle, ...{
    
    NSMutableArray *butNameArr = [[NSMutableArray alloc]init];
    [butNameArr addObject:butTitle];
    va_list args;
    va_start(args, butTitle);
    if (butTitle)
    {
        NSString *otherString;
        while ((otherString = va_arg(args, NSString *)))
        {
            [butNameArr addObject:otherString];
        }
    }
    va_end(args);
    switch (butNameArr.count) {
        case 1:
        {
            NSDictionary *alertDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                      title,@"UHConfirmAlert",
                                      msg,@"message",
                                      butNameArr[0],@"cancelBtn",
                                      nil];
            [UHAlertManager alertStyle:@"UHDefaulAlert" info:alertDic Controller:controller clickBlock:clickBlock];
            
            
        }break;
        case 2:{
            NSDictionary *alertDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                      title,@"alertTitle",
                                      msg,@"message",
                                      butNameArr[0],@"cancelBtn",
                                      butNameArr[1],@"confirmBtn",
                                      nil];
            [UHAlertManager alertStyle:@"UHDefaulAlert" info:alertDic Controller:controller clickBlock:clickBlock];
        }break;
            
        default:{
            
            [UHAlertManager alertSysMessage:msg title:title preferredStyle:UIAlertControllerStyleAlert Controller:controller clickBlock:clickBlock buttonArr:butNameArr];
        }break;
    }
}
@end
