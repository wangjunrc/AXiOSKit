//
//  AXUserSwiftImport.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/5/8.
//  Copyright © 2021 axinger. All rights reserved.
//

#ifndef AXUserSwiftImport_h
#define AXUserSwiftImport_h

//调用swift, 不可见文件


#if __has_include("AXiOSKit_Example-Swift.h")
#import "AXiOSKit_Example-Swift.h"
#elif __has_include("AXiOSKit_Example_Env_1-Swift.h")
#import "AXiOSKit_Example_Env_1-Swift.h"
#endif


#endif /* AXUserSwiftImport_h */
