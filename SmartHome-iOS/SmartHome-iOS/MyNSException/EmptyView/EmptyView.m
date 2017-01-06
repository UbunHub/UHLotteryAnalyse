//
//  EmptyView.m
//  HuiWang
//
//  Created by xiaoqy on 16/9/30.
//  Copyright © 2016年 com.sanweidu.TDDPayBLE. All rights reserved.
//

#import "EmptyView.h"

@implementation EmptyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"EmptyViewDefaul" owner:self options:nil][0];
    }
    return self;
}
-(void)layoutIfNeeded{
    
}
@end
