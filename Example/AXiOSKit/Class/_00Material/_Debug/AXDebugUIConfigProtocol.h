//
//  AXDebugUIConfigProtocol.h
//  AXiOSKit
//
//  Created by 小星星吃KFC on 2020/12/22.
//  Copyright © 2020 axinger. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AXDebugUIConfigProtocol <NSObject>

/// 点击按钮显示的根控制器
@property(nonatomic, strong) UIViewController *rootViewController;

@end

NS_ASSUME_NONNULL_END
