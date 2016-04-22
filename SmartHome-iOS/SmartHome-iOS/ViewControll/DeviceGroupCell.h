//
//  DeviceGroupCell.h
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/4/15.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserScenarioListData.h"

@interface DeviceGroupCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgimage;

-(void)relodeCellWithdata:(UserScenarioListData*)data;
@end
