//
//  Global_Variable.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/3/4.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "Global_Variable.h"

@implementation Global_Variable

static Global_Variable * sharedInstance =nil;

+(Global_Variable *) sharedInstance{

    @synchronized(self)
    {
        if (sharedInstance ==nil){

            sharedInstance = [[Global_Variable alloc]init];
        }
    }
    return sharedInstance;
}

+(id)allocWithZone:(NSZone *)zone{

    @synchronized(self)
    {
        if (sharedInstance ==nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return nil;
}
@end
