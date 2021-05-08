//
//  DLSharePopAction.h
//  AXiOSKitExample
//
//  Created by 小星星吃KFC on 2021/4/30.
//  Copyright © 2021 axinger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AXShareTarget.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXShareOption : NSObject

@property(nonatomic, copy) NSString *title;

@property(nonatomic, copy) NSString *appName;

/// 下载地址
@property(nonatomic, copy) NSString *appLink;

@property(nonatomic, copy) NSString *iconName;

@property(nonatomic, copy) AXShareTarget type;

@property(nonatomic, copy) void(^didBlock)(AXShareTarget type);


@end

NS_ASSUME_NONNULL_END
