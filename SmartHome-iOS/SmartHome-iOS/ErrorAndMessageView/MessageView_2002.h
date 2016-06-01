//
//  MessageView_2002.h
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/5/9.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageView_2002 : UIViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activitView;
@property (weak, nonatomic) IBOutlet UIView *alertImageView;

-(void)reloadViewWithData:(NSDictionary*)data;
@end
