//
//  DeviceGroupCell.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/4/15.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "DeviceGroupCell.h"
#import "UIImageView+WebCache.h"
@implementation DeviceGroupCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"DeviceGroupCell" owner:self options: nil];
        if(arrayOfViews.count < 1){return nil;}
        if(![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]){
            return nil;
        }
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}


-(void)relodeCellWithdata:(UserScenarioListData*)data{
    _titleLabel.text = data.scenarioName;
    [_bgimage sd_setImageWithURL:[NSURL URLWithString:data.scenariopic]];
}
@end
