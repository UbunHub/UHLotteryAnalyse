//
//  NSDictionary+NSDictionaryCategory.h
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/3/4.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NSDictionaryCategory)

/**
 * 将NSDictionary格式数据转换为json格式的NSString
 */
- (NSString*) jsonStringWithPrettyPrint:(BOOL) prettyPrint;

/**
 * 将NSDictionary格式数据转换为xml格式的NSString
 */
- (NSString*)xmlStringWithStartElement:(NSString*)startElement isFirstElement:(BOOL) isFirstElement;
@end
