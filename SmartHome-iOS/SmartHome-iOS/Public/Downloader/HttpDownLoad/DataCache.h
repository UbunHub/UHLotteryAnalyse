//
//  DataCache.h
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/7/12.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpDownloaderCompat.h"

typedef NS_ENUM(NSInteger, DataCacheType) {
   
    DataCacheTypeNone,
    DataCacheTypeDisk,
    DataCacheTypeMemory
};

typedef void(^DataQueryCompletedBlock)(NSData *data, DataCacheType cacheType);

typedef void(^DataCheckCacheCompletionBlock)(BOOL isInCache);

typedef void(^DataCalculateSizeBlock)(NSUInteger fileCount, NSUInteger totalSize);

@interface DataCache : NSObject

/**
 * use memory cache [defaults to YES]
 */
@property (assign, nonatomic) BOOL shouldCacheImagesInMemory;

/**
 *  disable iCloud backup [defaults to YES]
 */
@property (assign, nonatomic) BOOL shouldDisableiCloud;

+ (DataCache *)sharedDataCache;

- (NSOperation *)queryDiskCacheForKey:(NSString *)key done:(DataQueryCompletedBlock)doneBlock;

- (void)storeRecalculate:(BOOL)recalculate Data:(NSData *)data forKey:(NSString *)key toDisk:(BOOL)toDisk;

/**
 * Query the memory cache synchronously.
 *
 * @param key The unique key used to store the wanted data
 */
- (NSData *)dataFromMemoryCacheForKey:(NSString *)key;

/**
 * Query the disk cache synchronously after checking the memory cache.
 *
 * @param key The unique key used to store the wanted data
 */
- (NSData *)dataFromDiskCacheForKey:(NSString *)key;

@end
