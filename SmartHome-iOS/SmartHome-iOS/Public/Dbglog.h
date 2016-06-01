//
//  Dbglog.h
//  ObjcDbglog
//
//  Created by user on 12-11-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef __DBGLOG_H_
#define __DBGLOG_H_

#define EnableDbgLogToFile(LogFileName) \
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); \
    NSString *documentsDirectory = [paths objectAtIndex:0]; \
    NSString *fileName =[NSString stringWithFormat:@"%@",LogFileName]; \
    NSString *logFilePath = [documentsDirectory stringByAppendingPathComponent:fileName]; \
    \
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "w+", stderr); \

#if TARGET_IPHONE_SIMULATOR
    #define DbgLog(format, ...) NSLog(format, ## __VA_ARGS__)
#elif TARGET_OS_IPHONE
    #ifdef DEBUG
        #define DbgLog(format, ...) NSLog(format, ## __VA_ARGS__)
    #else
        #define DbgLog(format, ...)
    #endif
#else
    #define DbgLog(format, ...) NSLog(format, ## __VA_ARGS__)
#endif

#endif