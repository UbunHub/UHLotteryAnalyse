//
//  UHAlertManager.h
//  Pods
//
//  Created by xiaoqy on 16/9/7.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UHAlertviewSuperVC.h"
#import "MBProgressHUD.h"

@interface UHAlertManager : NSObject

/**
 * 显示AlertView
 * style 样式（就是类名）
 * conview 容器view
 ＊ clickBlock
 */
+(void)alertStyle:(NSString*)style
             info:(NSDictionary*)info
       Controller:(UIViewController*)controller
       clickBlock:(UHAlertClickBlock)clickBlock;

+(void)showLoadinfo:(NSDictionary*)info
         Conview:(UIView*)conview;

+(void)hiddleLoad;



#pragma mark常用的几种
//系统样式
+(void)alertSysMessage:(NSString*)msg
                 title:(NSString*)title
            Controller:(UIViewController*)controller
            clickBlock:(UHAlertClickBlock)clickBlock
                button:(NSString*)butTitle, ...;

//系统样式
+(void)alertSheetSysMessage:(NSString*)msg
                 title:(NSString*)title
            Controller:(UIViewController*)controller
            clickBlock:(UHAlertClickBlock)clickBlock
                button:(NSString*)butTitle, ...;

//默认样式
+(void)alertDefaul:(NSString*)msg
             title:(NSString*)title
        Controller:(UIViewController*)controller
        clickBlock:(UHAlertClickBlock)clickBlock
            button:(NSString*)butTitle, ...;

@end
