//
//  RoundedUIButton.m
//  HLTddpay
//
//  Created by dev on 15/5/12.
//  Copyright (c) 2015年 com.sanweidu. All rights reserved.
//

#import "RoundedUIButton.h"

@implementation RoundedUIButton

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self == [super initWithCoder:aDecoder]) {
        self.layer.cornerRadius = 6;
    }
    return self;
}


@end
