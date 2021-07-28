//
//  DemoAppSetting.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2021/8/1.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AXiOSKit/AXMacros_instance.h>
NS_ASSUME_NONNULL_BEGIN

@interface DemoAppSetting : NSObject

AX_SINGLETON_INTER();

/// 是否允许旋转
@property (assign, nonatomic,getter=isAllowing) BOOL allowing;


@end

NS_ASSUME_NONNULL_END
