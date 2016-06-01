//
//  MessageView_2002.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/5/9.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "MessageView_2002.h"

@interface MessageView_2002 ()

@end

@implementation MessageView_2002

- (void)viewDidLoad {

    [super viewDidLoad];
    [self.view setFrame:CGRectMake(0, 0, Screen_width, Screen_height)];
}

-(void)reloadViewWithData:(NSDictionary*)data{
    [_activitView startAnimating];
     self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
     _alertImageView.layer.cornerRadius = 6;

}


@end
