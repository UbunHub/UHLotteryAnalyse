//
//  HttpDownloaderCompat.h
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/7/12.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#ifndef HttpDownloaderCompat_h
#define HttpDownloaderCompat_h

#if OS_OBJECT_USE_OBJC
#undef DispatchQueueRelease
#undef DispatchQueueSetterSementics
#define DispatchQueueRelease(q)
#define DispatchQueueSetterSementics strong
#else
#undef DispatchQueueRelease
#undef DispatchQueueSetterSementics
#define DispatchQueueRelease(q) (dispatch_release(q))
#define DispatchQueueSetterSementics assign
#endif


typedef void(^DataNoParamsBlock)();

#endif /* HttpDownloaderCompat_h */
