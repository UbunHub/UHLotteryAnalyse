//
//  FCCollectionViewCell.m
//  SmartHome-iOS
//
//  Created by Daniel on 16/8/30.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "FCCollectionViewCell.h"

@implementation FCCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"FCCollectionViewCell" owner:self options:nil] lastObject];
    }
    return self;
    
    
    
}
@end
