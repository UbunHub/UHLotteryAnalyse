//
//  DataDownloaderOperation.h
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/7/12.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataDownloader.h"
#import "HttpDownloaderCompat.h"
#import "DataOperation.h"

@interface DataDownloaderOperation : NSOperation<DataOperation,NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
/**
 * The request used by the operation's task.
 */
@property (strong, nonatomic, readonly) NSURLRequest *request;

/**
 * The operation's task
 */
@property (strong, nonatomic, readonly) NSURLSessionTask *dataTask;

/**
 * The expected size of data.
 */
@property (assign, nonatomic) NSInteger expectedSize;

/**
 * The response returned by the operation's connection.
 */
@property (strong, nonatomic) NSURLResponse *response;

/**
 * The DataDownloaderOptions for the receiver.
 */
@property (assign, nonatomic, readonly) DataDownloaderOptions options;

@property (assign, nonatomic) BOOL shouldDecompressImages;
/**
 * The credential used for authentication challenges in `-connection:didReceiveAuthenticationChallenge:`.
 *
 * This will be overridden by any shared credentials that exist for the username or password of the request URL, if present.
 */
@property (nonatomic, strong) NSURLCredential *credential;

/**
 *  Initializes a `DataDownloaderOperation` object
 *
 *  @see SDWebImageDownloaderOperation
 *
 *  @param request        the URL request
 *  @param session        the URL session in which this operation will run
 *  @param options        downloader options
 *  @param progressBlock  the block executed when a new chunk of data arrives.
 *                        @note the progress block is executed on a background queue
 *  @param completedBlock the block executed when the download is done.
 *                        @note the completed block is executed on the main queue for success. If errors are found, there is a chance the block will be executed on a background queue
 *  @param cancelBlock    the block executed if the download (operation) is cancelled
 *
 *  @return the initialized instance
 */
- (id)initWithRequest:(NSURLRequest *)request
            inSession:(NSURLSession *)session
              options:(DataDownloaderOptions)options
             progress:(DataDownloaderProgressBlock)progressBlock
            completed:(DataDownloaderCompletedBlock)completedBlock
            cancelled:(DataNoParamsBlock)cancelBlock;
@end
