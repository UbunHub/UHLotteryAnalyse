//
//  HttpDownloadManager.h
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/7/12.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataCache.h"
#import "DataDownloader.h"

typedef NS_OPTIONS(NSUInteger, HttpDownLoadOptions) {
    /**
     * By default, when a URL fail to be downloaded, the URL is blacklisted so the library won't keep trying.
     * This flag disable this blacklisting.
     */
    HttpDownLoadRetryFailed = 1 << 0,
    
    /**
     * This flag disables on-disk caching
     */
    HttpDownLoadCacheMemoryOnly = 1 << 2,
    
    /**
     * This flag enables progressive download, the image is displayed progressively during download as a browser would do.
     * By default, the image is only displayed once completely downloaded.
     */
    HttpDownLoadProgressiveDownload = 1 << 3,
    
    /**
     * Even if the image is cached, respect the HTTP response cache control, and refresh the image from remote location if needed.
     * The disk caching will be handled by NSURLCache instead of Data leading to slight performance degradation.
     * This option helps deal with images changing behind the same request URL, e.g. Facebook graph api profile pics.
     * If a cached image is refreshed, the completion block is called once with the cached image and again with the final image.
     *
     * Use this flag only if you can't make your URLs static with embedded cache busting parameter.
     */
    HttpDownLoadRefreshCached = 1 << 4,
    
};


typedef void(^HttpDownLoadProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);
typedef void(^HttpDownLoadCompletionWithFinishedBlock)(NSData *data, NSError *error, DataCacheType cacheType, BOOL finished, NSURL *imageURL);
typedef NSString *(^DataCacheKeyFilterBlock)(NSURL *url);

@interface HttpDownloadManager : NSObject

@property (strong, nonatomic, readonly) DataCache *dataCache;
@property (strong, nonatomic, readonly) DataDownloader *dataDownloader;

/**
 * The cache filter is a block used each time HttpDownLoadManager need to convert an URL into a cache key. This can
 * be used to remove dynamic part of an data URL.
 *
 * The following example sets a filter in the application delegate that will remove any query-string from the
 * URL before to use it as a cache key:
 *
 * @code
 
 [[SDWebImageManager sharedManager] setCacheKeyFilter:^(NSURL *url) {
 url = [[NSURL alloc] initWithScheme:url.scheme host:url.host path:url.path];
 return [url absoluteString];
 }];
 
 * @endcode
 */
@property (nonatomic, copy) DataCacheKeyFilterBlock cacheKeyFilter;


/**
 * Returns global HttpDownLoadManager instance.
 *
 * @return HttpDownLoadManager shared instance
 */
+ (id)sharedManager;

/**
 * Allows to specify instance of cache and image downloader used with data manager.
 * @return new instance of `HttpDownLoadManager` with specified cache and downloader.
 */
- (instancetype)initWithCache:(DataCache *)cache downloader:(DataDownloader *)downloader;

- (id)downloadImageWithURL:(NSURL *)url
                   options:(HttpDownLoadOptions)options
                  progress:(HttpDownLoadProgressBlock)progressBlock
                 completed:(HttpDownLoadCompletionWithFinishedBlock)completedBlock;

/**
 * Cancel all current operations
 */
- (void)cancelAll;

/**
 * Check one or more operations running
 */
- (BOOL)isRunning;
@end
