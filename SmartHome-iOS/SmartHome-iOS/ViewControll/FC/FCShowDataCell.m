//
//  FCShowDataCell.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/8/18.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "FCShowDataCell.h"

@implementation FCShowDataCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"FCShowDataCell" owner:self options:nil]firstObject];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setUIWithData:(NSDictionary*)dic{
    
    _outNO_lab.text = [NSString stringWithFormat:@"第%@期",dic[@"outNO"]];
    _outDate_lab.text = [NSString stringWithFormat:@"%@",dic[@"outdate"]];
    _outNum_lab.text = [NSString stringWithFormat:@"%@ %@ %@",dic[@"out_bai"],dic[@"out_shi"],dic[@"out_ge"]];
}

@end
