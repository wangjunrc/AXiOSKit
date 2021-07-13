//
//  AXDebugManager.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/12/22.
//  Copyright © 2020 axinger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AXiOSKit/AXiOSKit.h>
#import "AXDebugUIConfigProtocol.h"
#import "AXDebugUIConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXDebugManager : NSObject

axShared_H(Manager)

@property (nonatomic, strong, readonly) id <AXDebugUIConfigProtocol> config;

@property (nonatomic, copy, readonly) AXDebugManager * (^ withConfig)(id<AXDebugUIConfigProtocol>(^)(UIViewController *vc));

@property (nonatomic, copy, readonly) void (^ start)(void);

@end

NS_ASSUME_NONNULL_END
