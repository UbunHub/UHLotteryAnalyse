//
//  DataCache.m
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/7/12.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import "DataCache.h"
#import <CommonCrypto/CommonDigest.h>

@interface AutoPurgeDataCache : NSCache

@end

@implementation AutoPurgeDataCache

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAllObjects) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    
}

@end


@interface DataCache ()

@property (strong, nonatomic) NSCache *memCache;
@property (strong, nonatomic) NSString *diskCachePath;
@property (strong, nonatomic) NSMutableArray *customPaths;
@property (DispatchQueueSetterSementics, nonatomic) dispatch_queue_t ioQueue;

@end

@implementation DataCache {
  NSFileManager *_fileManager;
}


+ (DataCache *)sharedDataCache {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (id)init {
    return [self initWithNamespace:@"default"];
}

- (id)initWithNamespace:(NSString *)ns {
    NSString *path = [self makeDiskCachePath:ns];
    return [self initWithNamespace:ns diskCacheDirectory:path];
}
- (id)initWithNamespace:(NSString *)ns diskCacheDirectory:(NSString *)directory {
    
    if ((self = [super init])) {
        
        NSString *fullNamespace = [@"com.hackemist.SDWebImageCache." stringByAppendingString:ns];
        // Create IO serial queue
        _ioQueue = dispatch_queue_create("com.hackemist.SDWebImageCache", DISPATCH_QUEUE_SERIAL);

        // Init the memory cache
        _memCache = [[AutoPurgeDataCache alloc] init];
        _memCache.name = fullNamespace;
        
        // Init the disk cache
        if (directory != nil) {
            _diskCachePath = [directory stringByAppendingPathComponent:fullNamespace];
        } else {
            NSString *path = [self makeDiskCachePath:ns];
            _diskCachePath = path;
        }
        // memory cache enabled
        _shouldCacheImagesInMemory = YES;

        dispatch_sync(_ioQueue, ^{
            _fileManager = [NSFileManager new];
        });
    }
    
    return self;
}

// Init the disk cache
-(NSString *)makeDiskCachePath:(NSString*)fullNamespace{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:fullNamespace];
}

- (NSOperation *)queryDiskCacheForKey:(NSString *)key done:(DataQueryCompletedBlock)doneBlock {
    if (!doneBlock) {
        return nil;
    }
    
    if (!key) {
        doneBlock(nil, DataCacheTypeNone);
        return nil;
    }
    
    // First check the in-memory cache...
    NSData *data = [self dataFromMemoryCacheForKey:key];
    if (data) {
        doneBlock(data, DataCacheTypeMemory);
        return nil;
    }
    
    NSOperation *operation = [NSOperation new];
    dispatch_async(self.ioQueue, ^{
        if (operation.isCancelled) {
            return;
        }
        
        @autoreleasepool {
            NSData *diskData = [self diskDataBySearchingAllPathsForKey:key];
            if (diskData && self.shouldCacheImagesInMemory) {
           
                [self.memCache setObject:diskData forKey:key cost:data.length];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                doneBlock(diskData, DataCacheTypeDisk);
            });
        }
    });
    
    return operation;
}

- (NSData *)dataFromMemoryCacheForKey:(NSString *)key {
    return [self.memCache objectForKey:key];
}

- (NSData *)dataFromDiskCacheForKey:(NSString *)key {
    
    // First check the in-memory cache...
    NSData *data = [self dataFromMemoryCacheForKey:key];
    if (data) {
        return data;
    }
    data = [self diskDataBySearchingAllPathsForKey:key];
    if (data) {
        return data;
    }
    return nil;
}


- (NSData *)diskDataBySearchingAllPathsForKey:(NSString *)key {
    
    NSString *defaultPath = [self defaultCachePathForKey:key];
    NSData *data = [NSData dataWithContentsOfFile:defaultPath];
    if (data) {
        return data;
    }
    data = [NSData dataWithContentsOfFile:[defaultPath stringByDeletingPathExtension]];
    if (data) {
        return data;
    }
    
    NSArray *customPaths = [self.customPaths copy];
    for (NSString *path in customPaths) {
        NSString *filePath = [self cachePathForKey:key inPath:path];
        NSData *imageData = [NSData dataWithContentsOfFile:filePath];
        if (imageData) {
            return imageData;
        }
        imageData = [NSData dataWithContentsOfFile:[filePath stringByDeletingPathExtension]];
        if (imageData) {
            return imageData;
        }
    }
    
    return nil;
}

- (NSString *)defaultCachePathForKey:(NSString *)key {
    return [self cachePathForKey:key inPath:self.diskCachePath];
}

- (NSString *)cachePathForKey:(NSString *)key inPath:(NSString *)path {
    NSString *filename = [self cachedFileNameForKey:key];
    return [path stringByAppendingPathComponent:filename];
}
- (void)storeRecalculate:(BOOL)recalculate Data:(NSData *)data forKey:(NSString *)key toDisk:(BOOL)toDisk {
    if (!data || !key) {
        return;
    }
    // if memory cache is enabled
    if (self.shouldCacheImagesInMemory) {
      
        [self.memCache setObject:data forKey:key cost:data.length];
    }
    
    if (toDisk) {
        dispatch_async(self.ioQueue, ^{
           
            
            if  (recalculate || !data) {

            [self storeDataToDisk:data forKey:key];
            }
        });
    }
}
- (void)storeDataToDisk:(NSData *)data forKey:(NSString *)key {
    
    if (!data) {
        return;
    }
    
    if (![_fileManager fileExistsAtPath:_diskCachePath]) {
        [_fileManager createDirectoryAtPath:_diskCachePath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    // get cache Path for image key
    NSString *cachePathForKey = [self defaultCachePathForKey:key];
    // transform to NSUrl
    NSURL *fileURL = [NSURL fileURLWithPath:cachePathForKey];
    
    [_fileManager createFileAtPath:cachePathForKey contents:data attributes:nil];
    
    // disable iCloud backup
    if (self.shouldDisableiCloud) {
        [fileURL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:nil];
    }
}
                       
#pragma mark DataCache (private)

- (NSString *)cachedFileNameForKey:(NSString *)key {
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                          r[11], r[12], r[13], r[14], r[15], [[key pathExtension] isEqualToString:@""] ? @"" : [NSString stringWithFormat:@".%@", [key pathExtension]]];
    
    return filename;
}
@end
