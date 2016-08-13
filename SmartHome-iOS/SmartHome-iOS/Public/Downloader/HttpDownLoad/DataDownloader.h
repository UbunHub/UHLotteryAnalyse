//
//  DataDownloader.h
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/7/12.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, DataDownloaderOptions) {
    DataDownloaderLowPriority = 1 << 0,
    DataDownloaderProgressiveDownload = 1 << 1,
    
    /**
     * By default, request prevent the use of NSURLCache. With this flag, NSURLCache
     * is used with default policies.
     */
    DataDownloaderUseNSURLCache = 1 << 2,
    
    /**
     * Call completion block with nil image/imageData if the image was read from NSURLCache
     */
    
    DataDownloaderIgnoreCachedResponse = 1 << 3,
    /**
     * In iOS 4+, continue the download of the image if the app goes to background. This is achieved by asking the system for
     * extra time in background to let the request finish. If the background task expires the operation will be cancelled.
     */
    
    DataDownloaderContinueInBackground = 1 << 4,
    
    /**
     * Handles cookies stored in NSHTTPCookieStore by setting
     * NSMutableURLRequest.HTTPShouldHandleCookies = YES;
     */
    DataDownloaderHandleCookies = 1 << 5,
    
    /**
     * Enable to allow untrusted SSL certificates.
     * Useful for testing purposes. Use with caution in production.
     */
    DataDownloaderAllowInvalidSSLCertificates = 1 << 6,
    
    /**
     * Put the image in the high priority queue.
     */
    DataDownloaderHighPriority = 1 << 7,
};

typedef NS_ENUM(NSInteger, DataDownloaderExecutionOrder) {
    /**
     * Default value. All download operations will execute in queue style (first-in-first-out).
     */
    DataDownloaderFIFOExecutionOrder,
    
    /**
     * All download operations will execute in stack style (last-in-first-out).
     */
    DataDownloaderLIFOExecutionOrder
};

typedef void(^DataDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);
typedef void(^DataDownloaderCompletedBlock)( NSData *data, NSError *error, BOOL finished);
typedef NSDictionary *(^DataDownloaderHeadersFilterBlock)(NSURL *url, NSDictionary *headers);

@interface DataDownloader : NSObject

/**
 *  Singleton method, returns the shared instance
 *
 *  @return global shared instance of downloader class
 */
+ (DataDownloader *)sharedDownloader;

/**
 * Decompressing images that are downloaded and cached can improve performance but can consume lot of memory.
 * Defaults to YES. Set this to NO if you are experiencing a crash due to excessive memory consumption.
 */
@property (assign, nonatomic) BOOL shouldDecompressImages;
/**
 *  Set the default URL credential to be set for request operations.
 */
@property (strong, nonatomic) NSURLCredential *urlCredential;

/**
 *  The timeout value (in seconds) for the download operation. Default: 15.0.
 */
@property (assign, nonatomic) NSTimeInterval downloadTimeout;

/**
 * Changes download operations execution order. Default value is `DataDownloaderFIFOExecutionOrder`.
 */
@property (assign, nonatomic) DataDownloaderExecutionOrder executionOrder;

/**
 * Set username
 */
@property (strong, nonatomic) NSString *username;

/**
 * Set password
 */
@property (strong, nonatomic) NSString *password;

/**
 * Set filter to pick headers for downloading image HTTP request.
 *
 * This block will be invoked for each downloading image request, returned
 * NSDictionary will be used as headers in corresponding HTTP request.
 */
@property (nonatomic, copy) DataDownloaderHeadersFilterBlock headersFilter;

- (id)downloadDataWithURL:(NSURL *)url options:(DataDownloaderOptions)options progress:(DataDownloaderProgressBlock)progressBlock completed:(DataDownloaderCompletedBlock)completedBlock;
@end
