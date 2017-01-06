//
//  DefineValue.h
//  SmartHome-iOS
//
//  Created by xiaoqy on 16/3/4.
//  Copyright © 2016年 xiaoqy. All rights reserved.
//

#ifndef DefineValue_h
#define DefineValue_h

//屏幕大小
#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width

#define InterFacePort  8889

//#define InterFaceIP   @"http://localhost"
#define InterFaceIP   @"http://192.168.1.27"
//#define InterFaceIP   @"http://45.78.9.162"

#define UGImage(image)   [NSURL URLWithString:[NSString stringWithFormat:@"%@/xiaoqy/UHPySever/Image/%@",InterFaceIP,image]]

#define UGColor(redValue,greenValue,BlueValue,alphaValue)  [UIColor colorWithRed:redValue/255.0 green:greenValue/255.0 blue:BlueValue/255.0 alpha:alphaValue]

#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#endif /* DefineValue_h */
