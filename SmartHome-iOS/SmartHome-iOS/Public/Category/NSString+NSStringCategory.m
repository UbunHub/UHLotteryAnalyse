//
//  NSString+NSStringCategory.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/3/4.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "NSString+NSStringCategory.h"

@implementation NSString (NSStringCategory)

/**
 * 判断string是否为全数字
 */
- (BOOL)isNumbers{
    
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
    
}
@end
