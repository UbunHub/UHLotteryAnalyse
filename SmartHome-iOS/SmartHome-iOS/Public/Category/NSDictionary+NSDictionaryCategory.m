//
//  NSDictionary+NSDictionaryCategory.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/3/4.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "NSDictionary+NSDictionaryCategory.h"

@implementation NSDictionary (NSDictionaryCategory)

/**
 * 将NSDictionary格式数据转换为json格式的NSString
 */
-(NSString*) jsonStringWithPrettyPrint:(BOOL) prettyPrint {
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

/**
 * 将NSDictionary格式数据转换为xml格式的NSString
 */
- (NSString*)xmlStringWithStartElement:(NSString*)startElement isFirstElement:(BOOL) isFirstElement{
    
    NSMutableString *xml = [[NSMutableString alloc] initWithString:@""];
    NSArray *arr = [self allKeys];
    if (isFirstElement)
    {
        [xml appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"];
    }
    [xml appendString:[NSString stringWithFormat:@"<%@>\n", startElement]];
    for(int i=0; i < [arr count]; i++)
    {
        NSString *nodeName = [arr objectAtIndex:i];
        id nodeValue = [self objectForKey:nodeName];
        if([nodeValue isKindOfClass:[NSArray class]])
        {
            if([nodeValue count]>0)
            {
                for(int j=0;j<[nodeValue count];j++)
                {
                    id value = [nodeValue objectAtIndex:j];
                    if([value isKindOfClass:[NSDictionary class]])
                    {
                        [xml appendString:[value xmlStringWithStartElement:nodeName isFirstElement:NO]];
                    }
                }
            }
        }
        else if([nodeValue isKindOfClass:[NSDictionary class]])
        {
            [xml appendString:[nodeValue xmlStringWithStartElement:nodeName isFirstElement:NO]];
        }
        else
        {
            if([nodeValue length]>0){
                [xml appendString:[NSString stringWithFormat:@"<%@>",nodeName]];
                [xml appendString:[NSString stringWithFormat:@"%@",[self objectForKey:nodeName]]];
                [xml appendString:[NSString stringWithFormat:@"</%@>\n",nodeName]];
            }
        }
    }
    [xml appendString:[NSString stringWithFormat:@"</%@>\n",startElement]];
    
    NSString *finalxml=[xml stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    
    return finalxml;
}
@end
