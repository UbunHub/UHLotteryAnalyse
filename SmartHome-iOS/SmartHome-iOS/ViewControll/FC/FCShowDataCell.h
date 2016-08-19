//
//  FCShowDataCell.h
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/8/18.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCShowDataCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *outNO_lab;

@property (weak, nonatomic) IBOutlet UILabel *outDate_lab;

@property (weak, nonatomic) IBOutlet UILabel *outNum_lab;

-(void)setUIWithData:(NSDictionary*)dic;

@end
